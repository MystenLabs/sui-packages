module 0xc0fce5b34d74208998c3115dd3c722e256241e66a0a35ec7789a4ee38724e040::monalisa {
    struct MONALISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONALISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONALISA>(arg0, 6, b"MONALISA", b"MONA SIULA", b"First OG MONA on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6998_f9a506ab77.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONALISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONALISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

