module 0xbe3b0b2aeffbe4ee7625e1ddacbb9b76ca71b62f5fdb73652ea2d60108a67426::spol {
    struct SPOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOL>(arg0, 6, b"SPOL", b"Sui Polar", x"53554920504f4c41522c2074686520506f6c6172204265617220656d6f7469636f6e2c2069730a6c696b652061207265766f6c7574696f6e6172790a63727970746f63757272656e6379206f6e207468650a42415345206e6574776f726b2e204173207375690a7472616e73666f726d7320746865206469676974616c0a6d61726b6574706c6163652c2073756920504f4c41522069730a76616c7561626c65206f6e6c696e6520666f720a65787072657373696e6720656d6f74696f6e732e204765740a726561647920666f7220697473207265766f6c7574696f6e20696e0a6f6e6c696e6520696e746572616374696f6e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_3d497f673f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

