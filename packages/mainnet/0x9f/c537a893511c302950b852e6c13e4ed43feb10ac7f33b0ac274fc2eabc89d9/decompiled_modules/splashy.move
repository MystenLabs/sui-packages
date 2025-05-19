module 0x9fc537a893511c302950b852e6c13e4ed43feb10ac7f33b0ac274fc2eabc89d9::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHY>(arg0, 6, b"SPLASHY", b"Splashy The Ghost", x"53706c61736879207468652067686f737420726f616d732061726f756e642074686520537569206e6574776f726b2e20f09f91bb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747685258285.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

