module 0xb97baf6550373a9dbf8d967313fdb2b040a295b6e01ac5e618c90163fba65c43::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 6, b"XSUI", b"Meme of X", x"546869732070726f6a656374206973206372656174656420666f72205820616e6420656c6f6e206d75736b20666f7220737570706f7274696e6720646f676520616e64206d616e79206d6f7265206d656d65200a5472696275746520746f205820", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991922446.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

