module 0xdfedfa1c689bde4c1070c349c11ef318b998ec3eba6fdf4c3b38e9c5658fd5c8::doggod {
    struct DOGGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGGOD>(arg0, 6, b"DOGGOD", b"Doggod by SuiAI", b"Doggod", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dog2_1d8dbe4c17.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGGOD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGOD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

