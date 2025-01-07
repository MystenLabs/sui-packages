module 0xe23560aac0a5260e4d546976b64ea1949edad890d22477cce82a5c31f6da12d7::bobobi {
    struct BOBOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOBI>(arg0, 6, b"BOBOBI", b"BOBOBI on SUI", b"BOBOBI: The Accidental Memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bobobi_af794bff48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

