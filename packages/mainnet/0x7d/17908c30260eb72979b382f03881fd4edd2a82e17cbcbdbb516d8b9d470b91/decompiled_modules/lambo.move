module 0x7d17908c30260eb72979b382f03881fd4edd2a82e17cbcbdbb516d8b9d470b91::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 8, b"LAMBO", b"LAMBO", b"LAMBO FINANCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J04FI1V.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAMBO>(&mut v2, 110000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

