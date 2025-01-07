module 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdStore, arg3: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun register(arg0: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::register(arg0, arg1, arg2);
    }

    public entry fun change_admin(arg0: 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdAdminCap, arg1: address, arg2: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::Version) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::update_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::BirdStore, arg3: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::Version) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

