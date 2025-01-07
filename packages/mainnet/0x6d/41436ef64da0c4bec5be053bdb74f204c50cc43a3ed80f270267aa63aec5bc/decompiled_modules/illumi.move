module 0x6d41436ef64da0c4bec5be053bdb74f204c50cc43a3ed80f270267aa63aec5bc::illumi {
    struct ILLUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLUMI>(arg0, 9, b"Illumi", b"Illuminati", b"Illuminati coin for all Illuminaties", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILLUMI>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLUMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILLUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

