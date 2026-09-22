module 0xcd40dd0d8cf0277ef34f0a90033864f1a35d65de6ff5cea4cf3e5cdd1c3068c3::boost {
    struct BOOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOST>(arg0, 9, b"BOOST", b"Boosblast", b"Boosblast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blast.fun")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

