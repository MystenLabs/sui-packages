module 0xe4577b80d0ea2e35b5272222a3f2b5e2eb9da0e311faf341c033c91c46a2aa3d::kacy {
    struct KACY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KACY>, arg1: 0x2::coin::Coin<KACY>) {
        0x2::coin::burn<KACY>(arg0, arg1);
    }

    fun init(arg0: KACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KACY>(arg0, 9, b"KACY", b"markkacy", b"Mark Kacy your normie friend - Endorsed by the artist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/6QSVGUEyBZWRshnXKhS96NQ97vGWiTu61SyHLAbYpump.png?size=xl&key=6d2900")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KACY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KACY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KACY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KACY>>(v1, @0x49a74ec1759493ad9d0181dd2d0381c180d898271a3b86b1b75366e6fdfec6cb);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KACY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KACY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KACY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KACY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

