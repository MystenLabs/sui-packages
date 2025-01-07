module 0xd80c9d8987d3c1d2f463b98e205492946d64337b3ca09937c61abf604db7f6fe::squile {
    struct SQUILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUILE>(arg0, 6, b"SQUILE", b"Squile", x"546865726520617265206c6f7473206f66206c6974746c65206669736820746f20656174206f6e0a7468697320626c6f636b636861696e2c20616e6420537175696c652068617320616e0a656e646c6573732061707065746974652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_30_65754d73b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

