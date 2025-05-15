module 0xa4d910cd98e3ebcfdbf805a58f588c3173729dd94f0341e5e5e2ee2212ffc6c0::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"suidowoodo", x"537569646f776f6f646f20746f6f6b2074686520706f776572206f662053554920746f2065766f6c766520697473656c6620746f2061206d6f726520706f77657266756c20506f6bc3a96d6f6e2c206368616e67696e6720686973207479706520746f2077617465722e205769746820537569646f20696e20796f7572207465616d2c20796f752077696c6c20626520746865207665727920626573742074686174206e6f206f6e65206576657220776173210a0a537569646fc2b473206f626a65637469766520697320746f206d616b65205355492067726f77207769746820686973206e6577207761746572206162696c6974696573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbuwzifae24dw5wrcgl7kg6vbckdk23o7m2fsrotuymiokck6iye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

