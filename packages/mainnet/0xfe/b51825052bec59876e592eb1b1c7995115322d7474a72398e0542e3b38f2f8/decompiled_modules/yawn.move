module 0xfeb51825052bec59876e592eb1b1c7995115322d7474a72398e0542e3b38f2f8::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"Yawn's World", x"57656c636f6d6520746f0a5961776e7320576f726c642e0a4120676c6f62616c200a6272616e6420776974680a707572706f73650a5961776e206973206d6f7265207468616e2061206d656d6520636f696e2e20497473206120636f6d6d756e6974792c20776179206f66206c69666520616e64206120676c6f62616c6c79207265636f676e697a6564206272616e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x88ce174c655b6d11210a069b2c106632dabdb068_6146c7280d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

