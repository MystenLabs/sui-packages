module 0xf32cc8ea340ea5ff1cdddac234c10c12725214aa5f121bf6b31e44bc584201c7::garbage {
    struct GARBAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARBAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARBAGE>(arg0, 6, b"GARBAGE", b"TRUMP GARBAGE", x"43726f6f6b6564204a6f652049532054484520476172626167652e20204c79696e27204b616d616c612077696c6c20626520466972656421200a4d4147412121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dai_creation_a0fe4dfc9a6483c9cd4b9fe73308a5ed_38c4e5e13d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARBAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARBAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

