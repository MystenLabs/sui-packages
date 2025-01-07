module 0xe03ae327a08e537ac4d44127033fd028085aae86cb3aac72f4b52ffa7e115750::quby {
    struct QUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUBY>(arg0, 6, b"QUBY", b"QUBYSUI", b"QUBY ON SUI (official)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3655_dff8a5424d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

