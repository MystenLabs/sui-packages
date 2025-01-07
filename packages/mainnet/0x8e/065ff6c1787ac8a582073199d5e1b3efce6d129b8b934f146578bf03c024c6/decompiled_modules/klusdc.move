module 0x8e065ff6c1787ac8a582073199d5e1b3efce6d129b8b934f146578bf03c024c6::klusdc {
    struct KLUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f03f5e13daec5aa467a9a62cc11f0b9e141953adf1e90f073d76ce38f8fb48d::equity::create_treasury<KLUSDC>(arg0, 6, b"klUSDC", b"klUSDC", b"Kai Leverage USDC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0xfa101048aa5f13870111a1030db5cae049722dfe640122a3dfc80013ab41367f::init::PoolCreationTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>>(0xfa101048aa5f13870111a1030db5cae049722dfe640122a3dfc80013ab41367f::init::new_pool_creation_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

