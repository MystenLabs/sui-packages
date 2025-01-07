module 0x3e991cad3ea59adc7cee4b7f2be0b7f2231c54eb3ef448a784db649fdd6037bc::pacman {
    struct PACMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACMAN>(arg0, 6, b"PACMAN", b"PACMAN ON SUI", b"eating dots on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/666c72aa8a73f6b15a1fc39224f601f0_a5eee2093a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

