module 0xfb0c481cabeb173d4ddc5863c658043885073ca4c5a02010e24684619a3dfbc6::chon {
    struct CHON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHON>(arg0, 6, b"CHON", b"SUI CHON", b"Sui chon - Give rice to Suichon who lives in Sui's water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1343_9b3a5ffae6_f1ee76826b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHON>>(v1);
    }

    // decompiled from Move bytecode v6
}

