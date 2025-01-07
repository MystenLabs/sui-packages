module 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdStore, arg3: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::action(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun register(arg0: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::register(arg0, arg1, arg2);
    }

    public entry fun change_admin(arg0: 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdAdminCap, arg1: address, arg2: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::version::Version) {
        0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::update_admin(arg0, arg1, arg2);
    }

    public entry fun set_validator(arg0: &0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::BirdStore, arg3: &mut 0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::version::Version) {
        0xb3974393e926ea455948042750455f16a38fe849d04db48f36f7dda4d3a49122::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

