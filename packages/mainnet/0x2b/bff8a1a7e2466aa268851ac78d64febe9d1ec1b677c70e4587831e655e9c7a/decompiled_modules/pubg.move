module 0x2bbff8a1a7e2466aa268851ac78d64febe9d1ec1b677c70e4587831e655e9c7a::pubg {
    struct PUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUBG>(arg0, 9, b"PUBG", b"PUBG", b"PUBG Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUBG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUBG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

