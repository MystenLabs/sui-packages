module 0xbe0caff8857bfb1c600f8706f80c149706a9f3cb94acd037fc9c8ca0bbcf955d::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 9, b"GENGAR", b"GENGAR", b"GENGAR IS A MONSTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENGAR>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v2, @0xc522ec22d9935770c5459b2872c949e70e708c27fa36dd2f832619d239fbf68);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

