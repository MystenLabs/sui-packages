module 0x31be63ab8ef3791fd113fa34635ba136bdc1000c3228d8050af3fe557a6caffe::sia {
    struct SIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIA>(arg0, 6, b"SIA", b"SuiVerseIA", x"53756954656e736f725665727365207265766f6c7574696f6e697a6573206163636573736962696c69747920746f206172746966696369616c20696e74656c6c6967656e63652c206f70656e696e672074686520646f6f727320666f7220616c6c20696e646976696475616c732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitensor_2b0fd92664.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

