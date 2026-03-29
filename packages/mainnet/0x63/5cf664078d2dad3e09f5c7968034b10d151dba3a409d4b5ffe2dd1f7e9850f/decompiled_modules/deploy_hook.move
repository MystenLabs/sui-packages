module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::deploy_hook {
    public(friend) fun run(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::has(arg0)) {
            return
        };
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::set(arg0, 10000000000, 80000, 500, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

