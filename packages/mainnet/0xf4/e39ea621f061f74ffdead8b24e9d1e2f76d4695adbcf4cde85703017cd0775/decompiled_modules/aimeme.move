module 0xf4e39ea621f061f74ffdead8b24e9d1e2f76d4695adbcf4cde85703017cd0775::aimeme {
    struct AIMEME has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<AIMEME>,
    }

    public fun burn_tokens(arg0: &mut TreasuryCapHolder<AIMEME>, arg1: 0x2::coin::Coin<AIMEME>) {
        0x2::coin::burn<AIMEME>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: AIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMEME>(arg0, 7, b"BOBI", b"SuiBobi", x"46697273742d68616e64205355492065636f73797374656d20696e74656c20766961204053656354696d654861636b200a4561726e20446f6720546f6b656e2072657761726473202d20796f7572206f6e2d636861696e207761746368646f6720666f7220535549207844", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1925846099505336320/HKJo-rpu_400x400.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMEME>>(v1);
        let v2 = TreasuryCapHolder<AIMEME>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_transfer<TreasuryCapHolder<AIMEME>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_tokens(arg0: &mut TreasuryCapHolder<AIMEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AIMEME>(&arg0.treasury_cap) + arg1 <= 223000000, 1);
        0x2::coin::mint_and_transfer<AIMEME>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

