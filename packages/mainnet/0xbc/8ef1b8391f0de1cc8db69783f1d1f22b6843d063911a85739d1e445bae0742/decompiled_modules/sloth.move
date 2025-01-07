module 0xbc8ef1b8391f0de1cc8db69783f1d1f22b6843d063911a85739d1e445bae0742::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 6, b"Sloth", b"Sloth Coin", x"536c6f746820436f696e21207468652063727970746f63757272656e63792074686174206d6f76657320736c6f776572206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96554fec2d1162b3d982079279f52c72_82b1b9730f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

