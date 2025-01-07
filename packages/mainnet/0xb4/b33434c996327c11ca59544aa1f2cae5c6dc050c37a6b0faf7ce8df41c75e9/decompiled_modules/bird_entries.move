module 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::BirdStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun change_admin(arg0: 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::BirdAdminCap, arg1: address, arg2: &mut 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::version::Version) {
        0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::change_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::BirdAdminCap, arg1: address, arg2: &mut 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::Validator, arg3: &mut 0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::version::Version) {
        0xb4b33434c996327c11ca59544aa1f2cae5c6dc050c37a6b0faf7ce8df41c75e9::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

