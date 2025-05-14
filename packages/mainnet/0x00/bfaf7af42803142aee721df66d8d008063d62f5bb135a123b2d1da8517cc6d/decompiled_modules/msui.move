module 0xbfaf7af42803142aee721df66d8d008063d62f5bb135a123b2d1da8517cc6d::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 9, b"MSUI", b"MemeSUI", x"4d656d65205375692069732074686520756e6f6666696369616c206a6573746572206f66207468652053756920626c6f636b636861696e20e280942061206d656d6520636f696e20626f726e20746f206272696e67206c61756768732c2076696265732c20616e6420766f6c756d652e204974e2809973206e6f74206a757374206120746f6b656e2c206974e280997320612063756c747572616c206d6f76656d656e7420726964696e6720746865207761766573206f662066756e20616e6420464f4d4f2c20616c6c207768696c652073686f77696e67206f666620537569e280997320626c617a696e6720737065656420616e64206c6f772066656573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f4e302ff9684624033fc076a60b4efb8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

