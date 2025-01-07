module 0xe23402d8a707ed27d994f06a2435b70e31ae6d1fe72335d67ff63fe8b077ce3d::kfcat {
    struct KFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFCAT>(arg0, 6, b"KFCAT", b"KFC CAT SUI", x"636869636b656e62616c6c207468652077697a617264206361740a0a68747470733a2f2f782e636f6d2f4b46435f45532f7374617475732f31383433393536393738373831313335333331", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d06689126c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

