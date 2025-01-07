module 0xc5d2b65af74fcd6c22a147a3350ce11e0598118862ffc05828da9630db2651e1::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"Tipsy", b"Tipsy on Sui", x"4f6365616e206973206d79204b696e67646f6d20e280a8e280a8537569206d79205061726164697365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987570393.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIPSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

