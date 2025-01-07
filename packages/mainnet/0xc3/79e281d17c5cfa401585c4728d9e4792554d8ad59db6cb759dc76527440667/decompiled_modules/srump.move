module 0xc379e281d17c5cfa401585c4728d9e4792554d8ad59db6cb759dc76527440667::srump {
    struct SRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUMP>(arg0, 6, b"SRUMP", b"Sui Trump", b"Biggest, boldest coin on Sui. Winning, always. Believe SRUMP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Uzat_1acc193dcd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

