module 0x7d9f8687962e379d0a5b623396954ac86b7b92e2f9743a928b236d09ffdd34b0::babydogeonsui {
    struct BABYDOGEONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGEONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGEONSUI>(arg0, 6, b"BabydogeOnSui", b"BABYDOGE", b"Posted by Babydoge.sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5847_d83f36d502.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGEONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYDOGEONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

