module 0x380c60a85ee09f8a93b79c17a36fb5f0566ae9eba418e2c2e6cecd9c30dc330f::salt {
    struct SALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALT>(arg0, 6, b"SALT", b"Sui Salt", x"41206b657920696e6772656469656e7420696e206c6966652c20616e64206e6f77206f6e205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salt_ca98acc729.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

