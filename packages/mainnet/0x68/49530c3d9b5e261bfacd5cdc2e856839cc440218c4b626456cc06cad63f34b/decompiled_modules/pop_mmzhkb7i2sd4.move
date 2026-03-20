module 0x6849530c3d9b5e261bfacd5cdc2e856839cc440218c4b626456cc06cad63f34b::pop_mmzhkb7i2sd4 {
    struct POP_MMZHKB7I2SD4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP_MMZHKB7I2SD4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP_MMZHKB7I2SD4>(arg0, 9, b"POP", b"POP", b"$POP on sui blockchain will make crypto and trading more affordable and risk worthy especially to beginners. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmPnM1tLpEyrytHTdQUwyTyDRjJ4NTa7XQBufFwVibRTtT")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP_MMZHKB7I2SD4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP_MMZHKB7I2SD4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

