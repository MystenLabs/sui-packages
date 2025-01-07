module 0x8c8015fbaf1903aa856bac0ca743a7d2176303c34bbf03595f0f6eb6f4941ee::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"Magnet", b"SuiMagnet", x"746865204d61676e6574206d65616e7320736f6d657468696e67200a0a6974206d65616e20686f70650a0a6974206d65616e732062656c6965766520696e20736f6d657468696e67200a0a697473206f757220776f726c642c2065766572796f6e6520656c7365206973206a757374206c6976696e6720696e206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6073350886786187548_x_1232249a00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

