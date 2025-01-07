module 0x6b9b1cdf08ee451e312f5eaac013016a0a6ea59b39e3b50cf4f5903f9943b01f::siuis {
    struct SIUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUIS>(arg0, 6, b"SIUIS", b"siuis", b"siuis", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SIUIS>>(0x2::coin::mint<SIUIS>(&mut v2, 210000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUIS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

