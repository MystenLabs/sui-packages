module 0x97b688d929c46bb861e88586265c6f302b66aa4c27984a7934cdb14b00712d76::inveco {
    struct INVECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVECO>(arg0, 9, b"INVECO", b"INVESTCOIN", b"Investment coins ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a36078d7-4f68-4747-ab80-d30f823732d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INVECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

