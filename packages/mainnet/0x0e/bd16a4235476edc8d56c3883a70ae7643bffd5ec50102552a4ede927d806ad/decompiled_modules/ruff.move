module 0xebd16a4235476edc8d56c3883a70ae7643bffd5ec50102552a4ede927d806ad::ruff {
    struct RUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFF>(arg0, 6, b"RUFF", b"Ruff", b"Ruffin' around Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XQK_Zqth5_400x400_907638b1d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

