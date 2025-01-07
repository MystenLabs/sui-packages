module 0x43922e9de5cc4cd237f9a1363cbcc7faafed2e1734eab1efa5c05a308a4cd580::henry {
    struct HENRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENRY>(arg0, 6, b"HENRY", b"The Cat Sui", x"4e6f207574696c697479202d206a757374202448656e72790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_20_16_31_18_d12098d117.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

