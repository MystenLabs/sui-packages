module 0x5bb4f3539f61abdad691e5f17a786c178c953744f07f76bf10bbffb5990374a0::catlisa {
    struct CATLISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLISA>(arg0, 6, b"CATLISA", b"Catlisa", b"Imagine Mona Lisa as a Cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9631_e4c70129ae.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

