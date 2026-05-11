module 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::deploy_hook {
    public(friend) fun run(arg0: &mut 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::dapp_system::initialize_framework_fee<0x2::sui::SUI>(arg0, 80000, 500, 0x2::tx_context::sender(arg1), 3000, arg1);
    }

    // decompiled from Move bytecode v6
}

