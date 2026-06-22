module 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::genesis {
    public fun run(arg0: &mut 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::deploy_hook::run(arg0, arg1);
    }

    public(friend) fun migrate(arg0: &mut 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

