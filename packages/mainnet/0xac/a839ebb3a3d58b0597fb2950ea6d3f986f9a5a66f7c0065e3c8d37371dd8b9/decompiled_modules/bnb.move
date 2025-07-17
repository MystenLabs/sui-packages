module 0xaca839ebb3a3d58b0597fb2950ea6d3f986f9a5a66f7c0065e3c8d37371dd8b9::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"BNB", b"@suilaunchcoin $BNB + BNB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BNB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

