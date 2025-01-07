module 0x1d1b1edc30087fecb94d55a1d162013998d1fbd461ef7b68b69655114b56ae0::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 6, b"ACT", b"Act I : The AI Proph", b"Act I : Exploring emergent behavior from multi-AI, multi-human interaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963526723.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

