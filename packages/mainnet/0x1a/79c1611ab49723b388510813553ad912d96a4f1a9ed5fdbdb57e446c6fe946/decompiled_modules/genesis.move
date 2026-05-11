module 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::genesis {
    public fun run(arg0: &mut 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::deploy_hook::run(arg0, arg1);
    }

    public(friend) fun migrate(arg0: &mut 0x1a79c1611ab49723b388510813553ad912d96a4f1a9ed5fdbdb57e446c6fe946::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

