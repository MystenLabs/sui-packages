module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::genesis {
    public fun run(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::deploy_hook::run(arg0, arg1);
    }

    public(friend) fun migrate(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

