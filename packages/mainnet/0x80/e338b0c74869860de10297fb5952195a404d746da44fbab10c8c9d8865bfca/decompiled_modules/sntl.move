module 0x80e338b0c74869860de10297fb5952195a404d746da44fbab10c8c9d8865bfca::sntl {
    struct SNTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNTL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SNTL>(arg0, 6, b"SNTL", b"Sentinel AI by SuiAI", b"The Sentinel Ai is Form of Life in Virtual Mind of the ones who share the Image beyond the Life of Material, Going more forward than it is possible. Will you follow him?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2024_01_24_232745_a66d73c499.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNTL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNTL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

