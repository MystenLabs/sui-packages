module 0x3b3a1c43343e8072b7259055f5e9e0253f9d47575db3d5f453daea89561cfc2c::suidas {
    struct SUIDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDAS>(arg0, 6, b"SUIDAS", b"Suidas", b"Impossible Is Nothing - Let's follow the meta and make Suidas one of the biggest memecoins on Sui. Join us on Telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_05_at_11_01_14_274403e79d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

