module 0x66fe6852cedf5f656eceb4ced8c2e7c257c33bfbd94b4dd48a85659cf33114a9::horke {
    struct HORKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORKE>(arg0, 6, b"HORKE", b"Horke", x"6272696e67696e672074686520737069726974206f66206c6175676874657220616e6420746f6765746865726e65737320746f207468652063727970746f20776f726c642e20506f7765726564206279205375692773206661737420616e6420656666696369656e7420746563686e6f6c6f67792c20486f726b65206f666665727320612066756e20657870657269656e6365207768696c652070726f766964696e67206f70706f7274756e697469657320746f2067726f7720616c6f6e67736964652069747320636f6d6d756e6974792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736760822167.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

