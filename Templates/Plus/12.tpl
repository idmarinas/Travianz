<?php
//////////////     made by alq0rsan, improved by evader   /////////////////////////
if($session->gold >= 5){
    $MyGold = mysqli_query($database->dblink,"SELECT gold, b4 FROM ".TB_PREFIX."users WHERE `id`='".$session->uid."'") or die(mysqli_error($database->dblink));
    $golds = mysqli_fetch_array($MyGold);
	if($session->sit == 0) {
		if (mysqli_num_rows($MyGold)) {
			if($golds['gold'] >= 5) {
				if($golds['b4'] < time()) {
					mysqli_query($database->dblink,"UPDATE ".TB_PREFIX."users set b4 = '".(time()+PLUS_PRODUCTION)."' where `id`='".$session->uid."'") or die(mysqli_error($database->dblink));
				} else {
					mysqli_query($database->dblink,"UPDATE ".TB_PREFIX."users set b4 = '".($golds['b4']+PLUS_PRODUCTION)."' where `id`='".$session->uid."'") or die(mysqli_error($database->dblink));
				}
				$done1 = "+25% Production: Crop";
				mysqli_query($database->dblink,"UPDATE ".TB_PREFIX."users set gold = ".($session->gold-5)." where `id`='".$session->uid."'") or die(mysqli_error($database->dblink));
				mysqli_query($database->dblink,"INSERT INTO ".TB_PREFIX."gold_fin_log (wid,log) VALUES ('".$village->wid."', '+25%  Production: Crop')") or die(mysqli_error($database->dblink));
			} else {
				$done1 = "You need more gold";
			}
		} else {
			$done1 = "Failed crop attempt";
			mysqli_query($database->dblink,"INSERT INTO ".TB_PREFIX."gold_fin_log (wid,log) VALUES ('".$village->wid."', 'Failed +25%  Production: Crop')") or die(mysqli_error($database->dblink));
		}
	}
	header("Location: plus.php?id=3");
	exit;
}
 ?>