module 0xb155721b1220636dbe53e594bdaeb3d5a2a356a8e98add3e4cbc46a235a284f7::sp500 {
    struct SP500 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP500, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP500>(arg0, 6, b"SP500", b"Sui&P500", x"547261636b696e672074686520746f7020353030206e6f7468696e676e657373206f6e205355490a2d4a6f6b6520636f696e0a2d4e6f207574696c697479200a2d50757265204d656d657a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_763b32f396.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP500>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SP500>>(v1);
    }

    // decompiled from Move bytecode v6
}

