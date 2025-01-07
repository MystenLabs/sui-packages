module 0x6b2b8b6836a5944d1966aa1a548782beba0048ad2a307d71f144b367b0892cd4::xd {
    struct XD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XD>(arg0, 6, b"XD", b"EARTHWASFLAT", b"the first-ever meme coin on the Sui platform that brings flat Earth fantasies to life. XD what a joke.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000404706_6e28b98c4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XD>>(v1);
    }

    // decompiled from Move bytecode v6
}

