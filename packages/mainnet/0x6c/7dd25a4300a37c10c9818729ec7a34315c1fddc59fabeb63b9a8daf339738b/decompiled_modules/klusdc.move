module 0x6c7dd25a4300a37c10c9818729ec7a34315c1fddc59fabeb63b9a8daf339738b::klusdc {
    struct KLUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x54e96a877b6ed36e953af673efbe82aaa260be3c16a668b4c89b8ee5eb312918::equity::create_treasury<KLUSDC>(arg0, 6, b"klUSDC-2", b"klUSDC-2", b"Kai Leverage USDC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xe06df7f659fa9fd1a4fd002e3844bcbed6cfc81bc72f02a028529c9e860c2503::init::PoolCreationTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>>(0xe06df7f659fa9fd1a4fd002e3844bcbed6cfc81bc72f02a028529c9e860c2503::init::new_pool_creation_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

