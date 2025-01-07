module 0xe00adae2c1d2cd5a261300c9a9dc041fedc206219f3d44295e5f38c5b5c661d6::homebound {
    struct HOMEBOUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMEBOUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMEBOUND>(arg0, 6, b"HomeBound", b"Home Bound", x"48656c6c6f20616e642077656c636f6d6520746f2074686520486f6d6520426f756e64204372697074207465616d2120f09f8c90204920616d207468652073616c616d616e646572206f662074686520537569206e6574776f726b2c20616e642049e280996d206865726520746f206163636f6d70616e7920796f752065766572792073746570206f6620746865207761792e2047657420726561647920666f722061206e657720776179206f66206c6f6f6b696e67206174207468652066696e616e6369616c206675747572652e204c6574e28099732067726f7720746f67657468657220616e64206578706c6f726520616c6c20746865206f70706f7274", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731084999680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMEBOUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMEBOUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

