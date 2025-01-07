module 0xeab18ea434493c929915ac7d4e225333b027928debfc41ed2565ae0c1e3e32a2::neptunus {
    struct NEPTUNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNUS>(arg0, 6, b"NEPTUNUS", b"Neptunus", b"AI SMART TRADE BOT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_17_18_32_14_6ff342a368.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPTUNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

