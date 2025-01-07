module 0xb6bf6f373557d3fc2c4e8cfffe36957ac71fec75dceaaf5f74de9bb26d9357b8::mp {
    struct MP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MP>(arg0, 6, b"MP", b"MicPepe", b"The Pepe study migic became MicPepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4026_a0903985c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MP>>(v1);
    }

    // decompiled from Move bytecode v6
}

