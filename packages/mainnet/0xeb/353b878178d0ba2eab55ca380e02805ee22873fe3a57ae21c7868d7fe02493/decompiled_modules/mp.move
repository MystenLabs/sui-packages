module 0xeb353b878178d0ba2eab55ca380e02805ee22873fe3a57ae21c7868d7fe02493::mp {
    struct MP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MP>(arg0, 6, b"MP", b"MovePump", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Move_logo_4f8b124e12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MP>>(v1);
    }

    // decompiled from Move bytecode v6
}

