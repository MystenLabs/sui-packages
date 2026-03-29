module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::genesis {
    public entry fun run(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_system::create_dapp<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), 0x1::ascii::string(b"dubhe"), 0x1::ascii::string(b"Dubhe Protocol"), arg1, arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::deploy_hook::run(arg0, arg2);
    }

    public(friend) fun migrate(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

