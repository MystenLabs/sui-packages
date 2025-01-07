module 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::BirdStore, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::action(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun change_admin(arg0: 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::BirdAdminCap, arg1: address, arg2: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::Version) {
        0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::change_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::BirdStore, arg3: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::Version) {
        0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

