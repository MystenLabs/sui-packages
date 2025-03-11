module 0x90f8a86428aa55f59cfb876e52c43d86f2a0467ffe01e0d72faddd60a8da43f5::asdfje {
    struct ASDFJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFJE>(arg0, 9, b"ASDFJE", b"AsdfjeToken", b"A test token on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASDFJE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFJE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDFJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

