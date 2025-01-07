module 0x721b2d97b8fd2a2e93a266f2b0f961fc9e4b9762cc5d8239b63716b4ee749502::infnum {
    struct INFNUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFNUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFNUM>(arg0, 6, b"INFNUM", b"inFINIUM ON SUI", x"57656c636f6d6520746f20746865206e65772062696767657374207468696e672ef09f9a80f09faa900a0a546865726520617265206d756c7469706c6520696e66696e697465207468696e6773207468657265666f726520696e66696e6974792069736ee2809974207468652062696767657374207468696e672e20546865206269676765737420697320696e66696e49554d2c20776869636820697320696e66696e69747920706c757320616c6c20746865206f7468657220696e66696e697465207468696e67732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732474061764.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INFNUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFNUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

