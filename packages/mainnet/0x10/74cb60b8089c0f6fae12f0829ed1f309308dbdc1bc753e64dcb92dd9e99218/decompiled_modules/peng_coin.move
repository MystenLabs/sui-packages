module 0x1074cb60b8089c0f6fae12f0829ed1f309308dbdc1bc753e64dcb92dd9e99218::peng_coin {
    struct PENG_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG_COIN>(arg0, 9, b"Peng_coin", b"Penguin", x"f09f90a7205468652066697273742063726f73732d657965642070656e6775696e206f6e2053756920f09f8c8a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/561565fbd4e12263ca83eed89b36148ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

