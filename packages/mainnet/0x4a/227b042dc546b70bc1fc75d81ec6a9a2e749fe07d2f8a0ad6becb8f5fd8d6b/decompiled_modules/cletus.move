module 0x4a227b042dc546b70bc1fc75d81ec6a9a2e749fe07d2f8a0ad6becb8f5fd8d6b::cletus {
    struct CLETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLETUS>(arg0, 6, b"CLETUS", b"Cletus", b"Cletus Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732102293141.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLETUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

