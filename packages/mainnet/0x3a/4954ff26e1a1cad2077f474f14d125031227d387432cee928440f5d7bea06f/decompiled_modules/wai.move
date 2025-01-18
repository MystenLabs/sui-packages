module 0x3a4954ff26e1a1cad2077f474f14d125031227d387432cee928440f5d7bea06f::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"Wolf AI", b"Wolf Al is an open-source framework that bridges Al and human innovation, enabling decentralized intelligence through modular systems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2193_393053f963.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

