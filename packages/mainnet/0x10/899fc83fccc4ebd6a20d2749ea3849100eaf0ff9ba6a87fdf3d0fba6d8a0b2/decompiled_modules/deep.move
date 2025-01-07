module 0x10899fc83fccc4ebd6a20d2749ea3849100eaf0ff9ba6a87fdf3d0fba6d8a0b2::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    struct TreasuryAccess has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DEEP>,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 0, b"DEEP", b"Deep Token", b"The DEEP token secures the DeepBook protocol, the premier wholesale liquidity venue for on-chain trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deepbook.tech/icon.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP>(&mut v2, 25700, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEP>>(v1);
        let v3 = TreasuryAccess{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<TreasuryAccess>(v3);
    }

    // decompiled from Move bytecode v6
}

