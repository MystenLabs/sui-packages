module 0xab9c0e250e178cdcc667c1ee193b3e3b8b0fe34ccba8e658c110e5435ad866b0::dby {
    struct DBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBY>(arg0, 6, b"DBY", b"DinoByte On Sui", x"5468652044494e4f4259544520636f696e20636f6d6d756e6974792069732067726f77696e67207374726f6e676572206576657279206461792c0a776974682068696c6172696f7573206d656d6520636f6e746573747320616e642063726561746976652070726f6a656374732e2057696c6c0a44494e4f4259544520636f696e207265616c6c79206265636f6d65206120276d6f6e7374657227207468617420646f6d696e61746573207468650a6d61726b65743f204c6574277320666f6c6c6f7720616e642066696e64206f75742122", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Happy_1_606868cc4e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

