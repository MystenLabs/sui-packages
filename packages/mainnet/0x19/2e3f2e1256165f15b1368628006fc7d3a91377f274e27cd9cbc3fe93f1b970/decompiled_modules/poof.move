module 0x192e3f2e1256165f15b1368628006fc7d3a91377f274e27cd9cbc3fe93f1b970::poof {
    struct POOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOF>(arg0, 9, b"POOF", b"POOF", b"piff poof puff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POOF>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

