module 0x168148f8e710db8cf8cb8b0971dc5a985c65ffa852d6bbcb23d18f5b924787e2::klusdc {
    struct KLUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::create_treasury<KLUSDC>(arg0, 6, b"klUSDC", b"klUSDC", b"Kai Leverage USDC Supply Pool LP Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x9b63ab6504469380567a1730404c491b468ada24a87a72a50e4c2174d29d14e0::init::PoolCreationTicket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>>(0x9b63ab6504469380567a1730404c491b468ada24a87a72a50e4c2174d29d14e0::init::new_pool_creation_ticket<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, KLUSDC>(v0, arg1), v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLUSDC>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

