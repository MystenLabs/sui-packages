module 0x39fd055cafde75d35c6222e2c75e5b90726c15e7dccee8b85cd718f256cc913d::kriya_vsui_lp {
    struct KRIYA_VSUI_LP has drop {
        dummy_field: bool,
    }

    struct KriyaLpVault has key {
        id: 0x2::object::UID,
        lp_token: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>,
        treasury_cap: 0x2::coin::TreasuryCap<KRIYA_VSUI_LP>,
    }

    public fun update_icon_url(arg0: &KriyaLpVault, arg1: &mut 0x2::coin::CoinMetadata<KRIYA_VSUI_LP>, arg2: 0x1::ascii::String) {
        0x2::coin::update_icon_url<KRIYA_VSUI_LP>(&arg0.treasury_cap, arg1, arg2);
    }

    public fun deposit(arg0: &mut KriyaLpVault, arg1: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KRIYA_VSUI_LP> {
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_join<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0.lp_token, arg1);
        0x2::coin::mint<KRIYA_VSUI_LP>(&mut arg0.treasury_cap, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg1), arg2)
    }

    fun init(arg0: KRIYA_VSUI_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYA_VSUI_LP>(arg0, 9, b"KVLP", b"KRIYA-VSUI-LP", b"Fungible token of vSUI/SUI LP on KriyaDEX", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYA_VSUI_LP>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRIYA_VSUI_LP>>(v1, v2);
    }

    public fun init_vault(arg0: 0x2::coin::TreasuryCap<KRIYA_VSUI_LP>, arg1: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KRIYA_VSUI_LP>(&mut arg0, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&arg1), 0x2::tx_context::sender(arg2), arg2);
        let v0 = KriyaLpVault{
            id           : 0x2::object::new(arg2),
            lp_token     : arg1,
            treasury_cap : arg0,
        };
        0x2::transfer::share_object<KriyaLpVault>(v0);
    }

    public fun withdraw(arg0: &mut KriyaLpVault, arg1: 0x2::coin::Coin<KRIYA_VSUI_LP>, arg2: &mut 0x2::tx_context::TxContext) : 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI> {
        0x2::coin::burn<KRIYA_VSUI_LP>(&mut arg0.treasury_cap, arg1);
        0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::lp_token_split<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>(&mut arg0.lp_token, 0x2::coin::value<KRIYA_VSUI_LP>(&arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

