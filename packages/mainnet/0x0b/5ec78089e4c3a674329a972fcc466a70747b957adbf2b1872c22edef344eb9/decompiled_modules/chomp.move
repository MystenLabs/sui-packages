module 0xb5ec78089e4c3a674329a972fcc466a70747b957adbf2b1872c22edef344eb9::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"Chomp", b"Chomp SUI Turtle", x"43686f6d702c2074686520626c75652073656120747572746c652e0a4b696e67206f6620746865206465657020535549206f6365616e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chomp_SUI_Turtle_5bb1d6b7f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

