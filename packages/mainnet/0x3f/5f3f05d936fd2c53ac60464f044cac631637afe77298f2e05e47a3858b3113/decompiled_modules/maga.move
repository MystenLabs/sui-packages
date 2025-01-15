module 0x3f5f3f05d936fd2c53ac60464f044cac631637afe77298f2e05e47a3858b3113::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"TRUMP HAT by SuiAI", b"Trump with Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Trump_Hat_1513821a79.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

