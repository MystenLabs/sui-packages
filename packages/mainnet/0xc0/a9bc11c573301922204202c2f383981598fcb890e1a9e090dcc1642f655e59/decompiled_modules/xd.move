module 0xc0a9bc11c573301922204202c2f383981598fcb890e1a9e090dcc1642f655e59::xd {
    struct XD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XD>(arg0, 6, b"XD", b"X doge", b"X DOGE will change the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000743487_f9b3656564.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XD>>(v1);
    }

    // decompiled from Move bytecode v6
}

