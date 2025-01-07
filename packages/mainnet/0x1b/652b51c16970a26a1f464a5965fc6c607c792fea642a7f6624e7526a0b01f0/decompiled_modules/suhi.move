module 0x1b652b51c16970a26a1f464a5965fc6c607c792fea642a7f6624e7526a0b01f0::suhi {
    struct SUHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUHI>(arg0, 6, b"SUHI", b"Suhi on SUI", b"Shui means water in Chinese. Shui represents calmness, cheerfulness, joy, and nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUHI_f67aa715d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

