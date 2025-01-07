module 0x78e788efa6e93f2c1365b0b4404e11c4a022c18ec46aef37570e18748048ff58::dogimus {
    struct DOGIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGIMUS>(arg0, 6, b"DOGIMUS", b"DOGIMUs", b"Tesla Dogimus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xda4da6dc1dca253621a371ee2788951c90a9f117_c5923d8163.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

