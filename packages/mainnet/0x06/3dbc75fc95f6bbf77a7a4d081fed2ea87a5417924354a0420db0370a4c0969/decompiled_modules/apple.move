module 0x63dbc75fc95f6bbf77a7a4d081fed2ea87a5417924354a0420db0370a4c0969::apple {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLE>(arg0, 6, b"APPLE", x"4150504c4520f09f8d8e", x"416e206170706c65206973206120726f756e642c20656469626c6520667275697420746861742067726f7773206f6e20616e206170706c6520747265652c2077686963682069732070617274206f662074686520726f73652066616d696c792e200a4272696e67206c75636b20616e64206162756e64616e636520746f20616c6c206f6620796f7520212053756920467269656e64732021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732020079506.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

