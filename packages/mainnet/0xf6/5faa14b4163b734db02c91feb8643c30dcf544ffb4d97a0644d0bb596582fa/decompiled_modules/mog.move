module 0xf65faa14b4163b734db02c91feb8643c30dcf544ffb4d97a0644d0bb596582fa::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 6, b"MOG", b"Mog Coin", x"424e4220434841494e2057696c6c204d454c542046414345530a244d4f472069732074686520696e7465726e6574732066697273742063756c7475726520636f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724281019749_265dcce4ed6c88a4cc77c1f4c09de9c5_b38e22bce5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

