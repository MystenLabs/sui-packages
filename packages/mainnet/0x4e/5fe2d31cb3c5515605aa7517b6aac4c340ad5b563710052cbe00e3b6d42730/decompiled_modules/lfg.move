module 0x4e5fe2d31cb3c5515605aa7517b6aac4c340ad5b563710052cbe00e3b6d42730::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"LET'S FREAKING GO", x"54686520746f6b656e2074686174e280997320616c6c2061626f757420687970652c20656e657267792c20616e64206d616b696e67206576657279206d6f766520636f756e742120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731929980591.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

