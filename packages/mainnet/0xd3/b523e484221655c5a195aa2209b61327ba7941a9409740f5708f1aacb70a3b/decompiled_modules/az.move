module 0xd3b523e484221655c5a195aa2209b61327ba7941a9409740f5708f1aacb70a3b::az {
    struct AZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AZ>(arg0, 6, b"AZ", b"zri21 by SuiAI", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/449208088_1553554301897939_512765739532912111_n_56abe6c95b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

