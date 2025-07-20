module 0xb71229558543f8f85b4c94607329ede2945757b6d9caacb10e3a42a9d8f6c260::bbrook {
    struct BBROOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBROOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BBROOK>(arg0, 6, b"BBROOK", b"Baby Brook", b"BaBy Brook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_07_20_13_55_25_2f05132230.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBROOK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBROOK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

