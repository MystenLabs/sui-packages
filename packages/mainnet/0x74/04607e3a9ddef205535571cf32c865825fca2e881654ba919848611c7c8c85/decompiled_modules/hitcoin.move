module 0x7404607e3a9ddef205535571cf32c865825fca2e881654ba919848611c7c8c85::hitcoin {
    struct HITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITCOIN>(arg0, 6, b"Hitcoin", b"$hitcoin", x"57656c636f6d6520746f2074686520667574757265206f662066696e616e636520776974682024686974636f696e2c207468652063727970746f63757272656e637920736f20766973696f6e6172792c206974207472616e7363656e647320747261646974696f6e616c2065636f6e6f6d69637320737472616967687420696e746f207468652073657765722e204a6f696e206120636f6d6d756e697479207768657265207468652076616c756520706c756d6d65747320666173746572207468616e20796f757220686f706573206f6e2061204d6f6e646179206d6f726e696e672e0a24686974636f696e20697320666f72206c6f76657273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735886367636.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

