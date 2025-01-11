module 0xcfbcc3b9b6f5fe39d49a8fa33424a450f16bd005e996e304b0128aceaff37a72::suren {
    struct SUREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUREN>(arg0, 6, b"SUREN", b"Suren Kyuko", b"The fox girl guardian of $UI blockchain, with a heart full of love for anime and otaku culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_10_17_56_15_39562479ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

