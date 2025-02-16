module 0x96d14bd628537e5231a971163a6e4d5954354f0892eb61b8bd1dff1802d1a5a9::xbt {
    struct XBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBT>(arg0, 6, b"XBT", b"XBT Agent", b"XBT Agent is an AI Agent that trades autonomously on various chains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V8_Z40_Q_U_400x400_1_61a4731324.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

