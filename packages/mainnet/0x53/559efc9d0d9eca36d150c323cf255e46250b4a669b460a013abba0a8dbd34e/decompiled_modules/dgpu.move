module 0x53559efc9d0d9eca36d150c323cf255e46250b4a669b460a013abba0a8dbd34e::dgpu {
    struct DGPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGPU>(arg0, 6, b"DGPU", b"Dante GPU", b"DANTE-GPU is an AI agent marketplace and agent that intelligently recommends the combination of AI model and GPU that best suits users' needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735805567607.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

