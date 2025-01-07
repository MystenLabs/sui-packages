module 0x8262f808c8c5431f18f492159f7bd1a28834e99d6aa5a30afb4cf0c9a97e3f63::mlt {
    struct MLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLT>(arg0, 6, b"MLT", b"MELT", x"4d454c542049732054686520466972737420446f7865642057616c6c6574204d656d65206f6e205375690a0a4275696c64696e6720746f6765746865722c2077697468206f70656e20626f6f6b73200a616e6420686f6e6573742068616e64732e204576657279207472616e73616374696f6e2c200a6576657279206465636973696f6e20796f75727320746f207365652e200a5472616e73706172656e63792069736e7420612070726f6d6973652c2069747320612070726163746963652e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_830467606009_1_aa2d6bc0b7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

