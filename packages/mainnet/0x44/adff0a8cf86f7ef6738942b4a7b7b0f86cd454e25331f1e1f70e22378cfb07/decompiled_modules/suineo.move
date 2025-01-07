module 0x44adff0a8cf86f7ef6738942b4a7b7b0f86cd454e25331f1e1f70e22378cfb07::suineo {
    struct SUINEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEO>(arg0, 9, b"SUINEO", b"Suineo", x"5375696e656f2069732074686520666c617368792c206d697363686965766f7573206d656d6520726964696e6720746865207761766573206f66207468652053756921204a757374206c696b652053756e656fe2809973206c6f766520666f722073686f77696e67206f66662c20245375696e656f206272696e6773207374796c652c20737761676765722c20616e64206120626974206f6620706c617966756c206172726f67616e636520746f20746865205375692073706163652e202054656c656772616d3a2068747470733a2f2f742e6d652f7375695f6e656f2020576562736974653a20687474703a2f2f7375696e656f2e736974652020547769747465203a2068747470733a2f2f782e636f6d2f7375696e656f5f7375696e656f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/suineoonsui/suineo/refs/heads/main/suineo%20logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINEO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

