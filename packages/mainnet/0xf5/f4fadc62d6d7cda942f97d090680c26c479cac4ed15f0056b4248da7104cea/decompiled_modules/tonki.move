module 0xf5f4fadc62d6d7cda942f97d090680c26c479cac4ed15f0056b4248da7104cea::tonki {
    struct TONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONKI>(arg0, 9, b"Tonki", b"Tonki", b"wow toknki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONKI>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

