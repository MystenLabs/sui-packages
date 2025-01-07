module 0xa3929a76d0e1b08d7001f4283e7612d0123ce7b73dbf7afad1418867d97751f8::wojoe {
    struct WOJOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJOE>(arg0, 6, b"WOJOE", b"WoJogan", x"576f4a6f67616e0a0a224372617a7920696465612c206275742e2e2e222022576861742069663f2220576f726c647320636f6c6c6964652061667465722061206c617465206e6967687420444d542074726970207769746820796f7572206661766f7269746520706f6463617374657220616e64206d656d652e20496e74726f647563696e6720576f4a6f67616e2c20616c736f206b6e6f776e2061732c20576f4a6f652e204675656c696e6720796f75722074686f756768747320616e6420696e666c75656e63696e6720746865206d6173736573206f6e652074726970", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731697593571.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOJOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

