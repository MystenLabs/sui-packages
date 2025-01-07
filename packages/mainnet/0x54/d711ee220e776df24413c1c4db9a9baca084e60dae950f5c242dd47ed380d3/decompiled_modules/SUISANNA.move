module 0x54d711ee220e776df24413c1c4db9a9baca084e60dae950f5c242dd47ed380d3::SUISANNA {
    struct SUISANNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISANNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISANNA>(arg0, 6, b"SUISANNA", b"SUISANNA", b"LFFFFGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/b6h8Bm6.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISANNA>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISANNA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISANNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

