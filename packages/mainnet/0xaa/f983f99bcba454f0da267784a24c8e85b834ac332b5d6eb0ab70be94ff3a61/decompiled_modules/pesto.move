module 0xaaf983f99bcba454f0da267784a24c8e85b834ac332b5d6eb0ab70be94ff3a61::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"Pesto", b"PESTO", b"You know where I come from.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240925231858_214044bd80.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

