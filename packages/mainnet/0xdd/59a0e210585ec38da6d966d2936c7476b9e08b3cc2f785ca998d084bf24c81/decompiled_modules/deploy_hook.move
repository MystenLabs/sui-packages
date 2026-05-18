module 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::deploy_hook {
    public(friend) fun run(arg0: &mut 0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0xdd59a0e210585ec38da6d966d2936c7476b9e08b3cc2f785ca998d084bf24c81::dapp_system::initialize_framework_fee<0x2::sui::SUI>(arg0, 80000, 500, 0x2::tx_context::sender(arg1), 3000, arg1);
    }

    // decompiled from Move bytecode v6
}

