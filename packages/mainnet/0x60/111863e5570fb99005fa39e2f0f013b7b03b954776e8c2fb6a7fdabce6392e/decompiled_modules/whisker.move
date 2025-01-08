module 0x60111863e5570fb99005fa39e2f0f013b7b03b954776e8c2fb6a7fdabce6392e::whisker {
    struct WHISKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISKER>(arg0, 6, b"WHISKER", b"WHISKER SUI", x"57656c636f6d6520746f20576869736b65722c20746865206d656d6520746f6b656e2074686174206272696e67732068756d6f7220616e642074686520737069726974206f6620612063617420746f207468652063727970746f20776f726c6421204a6f696e20757320616e642073686f7720746861742063727970746f2069732066756c6c206f66206a6f7920746f6f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zdl_IGV_2_F_400x400_86dab27ee5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

