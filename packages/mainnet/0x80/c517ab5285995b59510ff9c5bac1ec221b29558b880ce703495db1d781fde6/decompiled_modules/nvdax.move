module 0x80c517ab5285995b59510ff9c5bac1ec221b29558b880ce703495db1d781fde6::nvdax {
    struct NVDAX has drop {
        dummy_field: bool,
    }

    struct NVDAXTreasuryCoinfig has store, key {
        id: 0x2::object::UID,
        treasuryCap: 0x2::coin::TreasuryCap<NVDAX>,
    }

    public fun buy(arg0: &mut NVDAXTreasuryCoinfig, arg1: &0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::config::Config, arg2: &mut 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::treasury::Treasury, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<NVDAX>, 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        (0x2::coin::mint<NVDAX>(&mut arg0.treasuryCap, arg4, arg7), 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::trade::buy_stock<NVDAX>(arg1, arg2, arg3, arg4, arg5, arg6, arg7))
    }

    fun init(arg0: NVDAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDAX>(arg0, 5, b"NVDAx", b"NVIDIA Depository Token", b"DR backed by NVDA (NASDAQ)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cro-ag.pages.dev/nvdax.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVDAX>>(v1);
        let v2 = NVDAXTreasuryCoinfig{
            id          : 0x2::object::new(arg1),
            treasuryCap : v0,
        };
        0x2::transfer::public_share_object<NVDAXTreasuryCoinfig>(v2);
    }

    public fun sell(arg0: &mut NVDAXTreasuryCoinfig, arg1: &0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::config::Config, arg2: &mut 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::treasury::Treasury, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64, arg5: 0x2::coin::Coin<NVDAX>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let (v0, v1) = 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::trade::sell_stock<NVDAX>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::coin::burn<NVDAX>(&mut arg0.treasuryCap, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

