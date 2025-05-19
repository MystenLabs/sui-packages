module 0x23f05bdbe7fbc8c8f118522388dd8be4df8ddd9b7679ab00d3c00fe631f2e62a::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHY>(arg0, 6, b"SPLASHY", b"Splashy The Ghost", b"Splashy the ghost roams around the Sui network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747685361634.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

