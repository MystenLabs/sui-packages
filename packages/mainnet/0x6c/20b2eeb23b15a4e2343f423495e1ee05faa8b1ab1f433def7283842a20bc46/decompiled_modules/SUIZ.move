module 0x6c20b2eeb23b15a4e2343f423495e1ee05faa8b1ab1f433def7283842a20bc46::SUIZ {
    struct SUIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIZ>(arg0, 6, b"SUIZ", b"ZEUS", b"GOD OF SUI MEMES, ALTER-EGO OF MATT FURIE AND ONLY DOG OF LEGENDARY PEPE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_1740_ccb09617ad.jpeg&w=256&q=75")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZ>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIZ>>(0x2::coin::mint<SUIZ>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIZ>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

