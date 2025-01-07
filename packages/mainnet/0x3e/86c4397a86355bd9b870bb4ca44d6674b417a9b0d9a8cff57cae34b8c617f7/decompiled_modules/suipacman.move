module 0x3e86c4397a86355bd9b870bb4ca44d6674b417a9b0d9a8cff57cae34b8c617f7::suipacman {
    struct SUIPACMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPACMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPACMAN>(arg0, 6, b"SuiPacman", b"Sui Pacman Official", b"Pacman is an Sui Blockchain based meme token, just enjoy it and happy trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pac_man_image_86c334280c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPACMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPACMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

