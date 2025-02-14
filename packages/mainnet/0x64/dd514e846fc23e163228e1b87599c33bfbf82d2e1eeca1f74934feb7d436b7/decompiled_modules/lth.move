module 0x64dd514e846fc23e163228e1b87599c33bfbf82d2e1eeca1f74934feb7d436b7::lth {
    struct LTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTH>(arg0, 6, b"LTH", b"Lithium AI", x"4c69746869756d204149207c2054686520467574757265206f662043727970746f20496e74656c6c6967656e636520f09f9a800a41492d706f7765726564206d61726b657420616e616c797369732c20736563757269747920262044654669206f7074696d697a6174696f6e2e20507265636973696f6e2c20656666696369656e63792c20616e6420696e6e6f766174696f6e2061636365737369626c652e20f09f948d0a4d6f726520696e666f7320696e207468652077686974652070617065722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739566306887.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

