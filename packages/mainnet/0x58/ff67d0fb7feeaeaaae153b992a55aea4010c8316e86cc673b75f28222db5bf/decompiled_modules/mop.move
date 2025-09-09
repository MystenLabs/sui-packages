module 0x58ff67d0fb7feeaeaaae153b992a55aea4010c8316e86cc673b75f28222db5bf::mop {
    struct MOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOP>(arg0, 6, b"MOP", b"MOPPY", b"Cleaning SUI Floors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjnz2hqq6z27t4ngmj4cthty5q4d4q3zlen7xb4ngkhsdtdpgbxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

