module 0xc68b81dad66a137116ad71a7a4b9790d3694214f2fd6d42d3adfe09a9c6ace8d::kwhale {
    struct KWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWHALE>(arg0, 6, b"KWHALE", b"KWHALE BOT", b"PREPARE FOR THE NEW MOVEPUMP BOT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd403842c594c809aa299e55251262af_d065ab9aa1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

