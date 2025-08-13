module 0xe24c4dabb7aec2ec3be2a99f8bd5c9476349ef562208b432786b6c47e747b69d::bigunderun {
    struct BIGUNDERUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGUNDERUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGUNDERUN>(arg0, 9, b"BIGUNDERUN", b"BIGI VUGI", b"dasdasdasdasdasdasdasdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGUNDERUN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGUNDERUN>>(v2, @0xf129ff0022c360c932fb549dff4debb7285552dc737084268b57f9d26e06a3a3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGUNDERUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

