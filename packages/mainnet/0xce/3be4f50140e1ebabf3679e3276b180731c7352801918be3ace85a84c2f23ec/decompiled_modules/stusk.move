module 0xce3be4f50140e1ebabf3679e3276b180731c7352801918be3ace85a84c2f23ec::stusk {
    struct STUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUSK>(arg0, 6, b"STUSK", b"protector tusk", b"Sui ocean protector tusk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1240_ec7a454929.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

