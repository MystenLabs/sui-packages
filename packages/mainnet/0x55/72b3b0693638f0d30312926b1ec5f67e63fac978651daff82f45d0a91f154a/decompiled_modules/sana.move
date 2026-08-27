module 0x5572b3b0693638f0d30312926b1ec5f67e63fac978651daff82f45d0a91f154a::sana {
    struct SANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANA>(arg0, 9, b"SANA", b"SAMA", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/yiBpp8qe1ud8Sl33_oVOVS7Yg2heyFC6j4wnP1HJv8Q")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SANA>>(0x2::coin::mint<SANA>(&mut v2, 1000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SANA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANA>>(v1);
    }

    // decompiled from Move bytecode v7
}

