module 0xf39783127ef9dec25e7edd03ad04c84df6587d5076821e6d6a0cf029e5b9fa1c::bull {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"SBULL", b"He is Master Bulltron. He behaved like a true gentleman. MasterBullTRON is generous with his time, wisdom, and resources. Be part of gentlemen's SUI-Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/121121_04f16c11e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

