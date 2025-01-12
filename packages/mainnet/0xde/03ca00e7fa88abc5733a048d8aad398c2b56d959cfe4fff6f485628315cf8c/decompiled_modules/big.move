module 0xde03ca00e7fa88abc5733a048d8aad398c2b56d959cfe4fff6f485628315cf8c::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 6, b"BiG", b"THEBiGOnE ", b"THEBiGOnE is a token based off of the bull run thats going to come its going to melt faces and make your wallet a BiGOnE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736719894206.01")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

