module 0x10c24573e39028d4928ffb46141bd6e7d6cd27d5367eaab8a361fbd1f0bd9762::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 6, b"SUITARD", b"The SUITARD", b"Suitard and Proud!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031307_75ff1f207c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

