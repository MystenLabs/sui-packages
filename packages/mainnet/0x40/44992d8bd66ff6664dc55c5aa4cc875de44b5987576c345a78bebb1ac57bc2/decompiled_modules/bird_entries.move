module 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::BirdStore, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::action(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun change_admin(arg0: 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::BirdAdminCap, arg1: address, arg2: &mut 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::version::Version) {
        0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::change_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::BirdStore, arg3: &mut 0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::version::Version) {
        0x4044992d8bd66ff6664dc55c5aa4cc875de44b5987576c345a78bebb1ac57bc2::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

