// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IsNumber(string){
	if (string_length(string_digits(string)) > 0) {
		return true;
	}
	return false;
}