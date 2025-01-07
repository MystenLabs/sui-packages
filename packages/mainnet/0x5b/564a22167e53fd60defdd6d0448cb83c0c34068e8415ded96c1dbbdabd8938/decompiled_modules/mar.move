module 0x5b564a22167e53fd60defdd6d0448cb83c0c34068e8415ded96c1dbbdabd8938::mar {
    struct MAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAR>(arg0, 6, b"MAR", b"MarMite", x"68747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d616d3666636f31344769302661625f6368616e6e656c3d546f6d536b610a612042726974697368207361766f75727920666f6f6420737072656164206261736564206f6e2079656173742065787472616374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marmait_0c8a25b352.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

