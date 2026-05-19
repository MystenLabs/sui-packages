module 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::deploy_hook {
    public(friend) fun run(arg0: &mut 0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x6cb54e8bbcf59cc976584330689073500af755b12d85bf4f56d7eea9f232b8aa::dapp_system::initialize_framework_fee<0x2::sui::SUI>(arg0, 80000, 500, 0x2::tx_context::sender(arg1), 3000, arg1);
    }

    // decompiled from Move bytecode v6
}

