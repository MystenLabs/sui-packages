module 0xfe0fbc9e755fe5ff6dafb1d6486789b6006a9a9af5c0a48c9032bf99f9de076a::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA by SuiAI", b"MELANIA Memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000021956_3a5ce4aef8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

