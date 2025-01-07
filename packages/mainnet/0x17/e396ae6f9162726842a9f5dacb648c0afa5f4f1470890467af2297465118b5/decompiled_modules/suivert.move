module 0x17e396ae6f9162726842a9f5dacb648c0afa5f4f1470890467af2297465118b5::suivert {
    struct SUIVERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVERT>(arg0, 6, b"SUIVERT", b"Lil Sui Vert", x"4c696c20555a49206f6e207375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffe27148_ac39_4696_8e5b_f8ebd35c25fb_1afabeab23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

