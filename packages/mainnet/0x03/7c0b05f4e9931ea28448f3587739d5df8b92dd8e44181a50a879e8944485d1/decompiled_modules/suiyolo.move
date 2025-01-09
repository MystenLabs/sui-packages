module 0x37c0b05f4e9931ea28448f3587739d5df8b92dd8e44181a50a879e8944485d1::suiyolo {
    struct SUIYOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYOLO>(arg0, 6, b"SUIYOLO", b"Sui YOLO", b"The official token of Sui YOLO Bot, Sui's premier volume & Rank Booster.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736392828197_7b2683c96f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

