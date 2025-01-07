module 0x3a55b3b5dafce2fcc8dbe80dd88d0c9665f3609c1765b3d5d290ee0b8da63b30::suilords {
    struct SUILORDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILORDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILORDS>(arg0, 6, b"SUILORDS", b"SuiLords", b"The Lords of Sui! Official Stealth Launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5559_6512781891.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILORDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILORDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

