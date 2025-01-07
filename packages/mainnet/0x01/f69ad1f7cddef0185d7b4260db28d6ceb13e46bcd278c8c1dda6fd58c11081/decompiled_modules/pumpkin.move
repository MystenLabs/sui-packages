module 0x1f69ad1f7cddef0185d7b4260db28d6ceb13e46bcd278c8c1dda6fd58c11081::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 6, b"Pumpkin", b"Sui Pumpkin", b"Pumpkin, The ultimate Halloween vibe on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pumpkin_f4638cb791.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

