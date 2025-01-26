module 0xb9d7a05881eaa674ad3aa5c9f814f57930f3200574b6de9a7d94c37df16c1ab2::wishingsnake2025 {
    struct WISHINGSNAKE2025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISHINGSNAKE2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISHINGSNAKE2025>(arg0, 6, b"WishingSnake2025", b"WishSnake", b"Wishing Snake of 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bt_D_Fkd_F_400x400_c55bf777ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISHINGSNAKE2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WISHINGSNAKE2025>>(v1);
    }

    // decompiled from Move bytecode v6
}

