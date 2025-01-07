module 0xa5196ae55504846d115b384681a49f5721c00d3ce1bca67f0aac2cc25b98de77::babyfud {
    struct BABYFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFUD>(arg0, 6, b"Babyfud", b"Baby FUD", x"42616279204655440a54686973206c6974746c6520707567207075707079206d617920626520736d616c6c2c20627574206974206861732062696720647265616d732c206a757374206c696b6520697473206661746865722e205769746820657965732066756c6c206f6620776f6e64657220616e6420612068656172742066756c6c206f6620686f70652c2069747320726561647920746f20636f6e717565722074686520776f726c64206f6e65207374657020617420612074696d652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000101479_0d90d17ccd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

