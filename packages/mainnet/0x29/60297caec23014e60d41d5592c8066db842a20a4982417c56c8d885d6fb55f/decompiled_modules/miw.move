module 0x2960297caec23014e60d41d5592c8066db842a20a4982417c56c8d885d6fb55f::miw {
    struct MIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIW>(arg0, 6, b"MiW", b"Maisie Williams", x"57656c636f6d6520746f20746865206e65772062696767657374207468696e672ef09f9a80f09faa9020546865726520617265206d756c7469706c6520696e66696e697465207468696e6773207468657265666f726520696e66696e6974792069736ee2809974207468652062696767657374207468696e672e205468652062696767657374206973204d69572c20776869636820697320696e66696e69747920706c757320616c6c20746865206f7468657220696e66696e697465207468696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732795817984.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

