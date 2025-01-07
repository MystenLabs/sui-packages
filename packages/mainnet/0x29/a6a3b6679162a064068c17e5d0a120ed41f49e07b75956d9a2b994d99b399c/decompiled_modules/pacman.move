module 0x29a6a3b6679162a064068c17e5d0a120ed41f49e07b75956d9a2b994d99b399c::pacman {
    struct PACMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACMAN>(arg0, 6, b"Pacman", b"Pacman on sui", b"Pacman is an Sui Blockchain based meme token, just enjoy it and happy trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pac_man_image_4cceeb9d1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

