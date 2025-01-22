module 0x6e1a4ec7473ac17432d749e8bf050c9e0f4008b09bdab49db12fd044b0a33923::trumpfi {
    struct TRUMPFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPFI>(arg0, 6, b"TRUMPFI", b"Trump Fight by SuiAI", b"hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pepe_b80ead9124.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPFI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

