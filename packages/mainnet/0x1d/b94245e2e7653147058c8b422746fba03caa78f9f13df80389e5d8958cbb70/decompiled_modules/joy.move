module 0x1db94245e2e7653147058c8b422746fba03caa78f9f13df80389e5d8958cbb70::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"Nurse Joy", b"Meet Joy, the charming nurse here to heal the boredom of the crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvpfcwgjumci3fhinwftmbu5hadnvb2bl4ffucw5ksdfwfwsgwzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

