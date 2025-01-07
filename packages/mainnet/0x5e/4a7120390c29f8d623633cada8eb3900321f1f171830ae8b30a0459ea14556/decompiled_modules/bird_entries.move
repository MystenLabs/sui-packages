module 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::BirdStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun change_admin(arg0: 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::BirdAdminCap, arg1: address, arg2: &mut 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::version::Version) {
        0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::change_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::BirdStore, arg3: &mut 0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::version::Version) {
        0x5e4a7120390c29f8d623633cada8eb3900321f1f171830ae8b30a0459ea14556::bird::set_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

