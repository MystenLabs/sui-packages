module 0x9b683aa9a9e00a55825c5f1e922c493ade456cf1d92a32b2db68834b19e9e28a::slushy {
    struct SLUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSHY>(arg0, 6, b"SLUSHY", b"SLUSHIES", b"Slushy RWA, Redeem 1 token for an ice cold Slushy or other Rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1785437001417.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLUSHY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUSHY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

