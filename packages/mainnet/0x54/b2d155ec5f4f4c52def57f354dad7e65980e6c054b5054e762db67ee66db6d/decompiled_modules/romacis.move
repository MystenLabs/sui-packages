module 0x54b2d155ec5f4f4c52def57f354dad7e65980e6c054b5054e762db67ee66db6d::romacis {
    struct ROMACIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMACIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMACIS>(arg0, 9, b"ROMACIS", b"romabis", b"the new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10c5b8ad-3501-49d5-b3d1-1c459d22f5da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMACIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROMACIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

