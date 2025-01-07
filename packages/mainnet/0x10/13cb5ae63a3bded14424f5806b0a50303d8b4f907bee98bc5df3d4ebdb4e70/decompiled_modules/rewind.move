module 0x1013cb5ae63a3bded14424f5806b0a50303d8b4f907bee98bc5df3d4ebdb4e70::rewind {
    struct REWIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: REWIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWIND>(arg0, 9, b"REWIND", b"Meme Rewind", b"MEMECOIN REWIND 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1868771322555432960/koLlt06R_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REWIND>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWIND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REWIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

