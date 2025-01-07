module 0xac115416480d0751d972a2b10bd3188b8371ef6041357193304d43b9e5c74c5b::wankai {
    struct WANKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WANKAI>(arg0, 6, b"WANKAI", b"hmilan0718 by SuiAI", b"SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f481cb89_f276_4152_af56_ce63bbf6828a_941abe4d2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WANKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

