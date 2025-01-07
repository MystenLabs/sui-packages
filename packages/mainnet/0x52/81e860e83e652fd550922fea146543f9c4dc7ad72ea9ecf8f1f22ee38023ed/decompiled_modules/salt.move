module 0x5281e860e83e652fd550922fea146543f9c4dc7ad72ea9ecf8f1f22ee38023ed::salt {
    struct SALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALT>(arg0, 6, b"SALT", b"Sui Salt", b"A key ingredient in life, and now... its on Sui! Its that essential kick for everything from ancient seas to Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salt_b1fa3306f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

