module 0xf8930f9840c4f2bcff669ff9b464c3eedb66be4bbae0f6af2df3b02c630354f0::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"hello fren, i am fin", x"6920616d206d656d6520746f6b656e20696e20535549776f726c642c20616e64206f6e6c7920756e697175650a637265617475726520696e2074686520776f726c642066756c6c206f6620646f677320616e6420636174732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f252be4b56bd3611ee637d61495a5a78_6921338ad9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

