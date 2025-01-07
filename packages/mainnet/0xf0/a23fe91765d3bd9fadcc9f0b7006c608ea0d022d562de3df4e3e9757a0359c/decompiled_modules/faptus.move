module 0xf0a23fe91765d3bd9fadcc9f0b7006c608ea0d022d562de3df4e3e9757a0359c::faptus {
    struct FAPTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAPTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAPTUS>(arg0, 6, b"Faptus", b"Fasterrrr than Sui", b"Faptus blooakchum, fastest blooakchum in the whole wide world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954536596.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAPTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAPTUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

