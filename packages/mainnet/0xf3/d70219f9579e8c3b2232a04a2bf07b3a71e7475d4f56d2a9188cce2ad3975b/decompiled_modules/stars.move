module 0xf3d70219f9579e8c3b2232a04a2bf07b3a71e7475d4f56d2a9188cce2ad3975b::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 9, b"STARS", b"STARS", b"Stars in the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STARS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

