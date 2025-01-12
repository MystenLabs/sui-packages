module 0xedbf6d23680ac11875fa8fbdf892618bd7af28d36bb65f743b2e20d7cba97eb4::funai {
    struct FUNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FUNAI>(arg0, 6, b"FUNAI", b"FUN AI by SuiAI", b"FUNAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_0fe2198636.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUNAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

