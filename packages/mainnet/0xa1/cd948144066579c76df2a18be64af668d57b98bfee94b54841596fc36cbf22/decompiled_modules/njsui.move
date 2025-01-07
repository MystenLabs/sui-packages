module 0xa1cd948144066579c76df2a18be64af668d57b98bfee94b54841596fc36cbf22::njsui {
    struct NJSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJSUI>(arg0, 6, b"NJSUI", b"Turtles Ninja Sui", x"547572746c6573204e696e6a612077696c6c206265205375692773206d6173636f742e20547572746c6573204e696e6a612773206669727374207075626c696320617070656172616e6365206174205375692e2057652c2074686520636f6d6d756e6974792c2077696c6c20676976652068696d2074686520617474656e74696f6e2068652064657365727665732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cho_uaung_c70d582046.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NJSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

