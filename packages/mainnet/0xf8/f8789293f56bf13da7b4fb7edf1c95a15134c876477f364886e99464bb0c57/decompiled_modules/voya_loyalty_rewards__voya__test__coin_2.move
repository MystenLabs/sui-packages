module 0xf8f8789293f56bf13da7b4fb7edf1c95a15134c876477f364886e99464bb0c57::voya_loyalty_rewards__voya__test__coin_2 {
    struct VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2 has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"VTC2", b"Voya Test Coin 2", b"The following contract regulates the functioning of VOYA Loyalty Rewards Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::set_rules<VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2>(&mut v4, &v3, arg1);
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::create_protected_treasury_policy_caps<VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2>(v0, v3, arg1);
        0x2::token::share_policy<VOYA_LOYALTY_REWARDS__VOYA__TEST__COIN_2>(v4);
    }

    // decompiled from Move bytecode v6
}

