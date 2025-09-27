module 0x71213feb14663376ed974c4fe6dc646b4a9e148ead150c5ade13e0326b4ac0c8::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 6, b"BEAN", b"Crazy Beanz", x"57656c636f6d6520746f204372617a79204265616e7a20e28094206120776562332067616d696669656420657870657269656e6365206f6e20746865202453554920626c6f636b636861696e2e204865726520637265617469766974792c206368616f732c20616e6420636f6d6d756e697479207468726976652e204372617a79204265616e7a206973206d6f7265207468616e206120636f6c6c656374696f6e20e28094206974e28099732061206d696e647365742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1758980463097.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

