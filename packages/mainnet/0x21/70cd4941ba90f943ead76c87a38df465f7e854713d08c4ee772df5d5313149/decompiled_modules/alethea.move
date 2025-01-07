module 0x2170cd4941ba90f943ead76c87a38df465f7e854713d08c4ee772df5d5313149::alethea {
    struct ALETHEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALETHEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALETHEA>(arg0, 6, b"Alethea", b"ALETHEA THE CUTE MERMAID", b"Alethea cute mermaid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_F1c_J_Ho_400x400_b6350f8a44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALETHEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALETHEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

