module 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdStore, arg3: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun register(arg0: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::register(arg0, arg1, arg2);
    }

    public entry fun change_admin(arg0: 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdAdminCap, arg1: address, arg2: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::version::Version) {
        0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::update_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::BirdStore, arg3: &mut 0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::version::Version) {
        0xedc14490687ee2e13e050a0e05a08366661fc7b6af06128346c805621a8cd71::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

