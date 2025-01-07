module 0x26896f5024bdb819f2e0c7891b7baee05eed2eb31695a624e0bbf8940f450f1a::quantvibes {
    struct QUANTVIBES has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTVIBES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTVIBES>(arg0, 6, b"QUANTVIBES", b"QUANT vibes", b"Just QUANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc17_Zq_DXMAAP_Eb3_49b0f8ece7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTVIBES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTVIBES>>(v1);
    }

    // decompiled from Move bytecode v6
}

