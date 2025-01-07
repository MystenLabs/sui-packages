module 0x27b254cebec5451974f420aab0a41439ed73d9630a7613ffa4ffe9adaa1866ed::bitoicp {
    struct BITOICP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOICP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOICP>(arg0, 8, b"bitoICP.sui", b"bito wrapped icp", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/coins/images/14495/standard/Internet_Computer_logo.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOICP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOICP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

