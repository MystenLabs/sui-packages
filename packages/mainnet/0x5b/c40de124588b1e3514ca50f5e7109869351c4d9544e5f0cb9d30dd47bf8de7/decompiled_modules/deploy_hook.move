module 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::deploy_hook {
    public(friend) fun run(arg0: &mut 0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x5bc40de124588b1e3514ca50f5e7109869351c4d9544e5f0cb9d30dd47bf8de7::dapp_system::initialize_framework_fee<0x2::sui::SUI>(arg0, 80000, 500, 0x2::tx_context::sender(arg1), 3000, arg1);
    }

    // decompiled from Move bytecode v6
}

