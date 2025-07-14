module 0x915ad04389adf7d6432aecd2c599fb970fc7d5e2db424080ba5ec6f395a98ec0::acst {
    struct ACST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACST>(arg0, 6, b"ACST", b"AltsCheatSheetToken", b"Alt season cheat sheet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752502653000.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

