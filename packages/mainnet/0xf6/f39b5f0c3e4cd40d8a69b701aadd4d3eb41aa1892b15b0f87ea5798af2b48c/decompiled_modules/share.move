module 0xf6f39b5f0c3e4cd40d8a69b701aadd4d3eb41aa1892b15b0f87ea5798af2b48c::share {
    struct SHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHARE>(arg0, 6, b"SHARE", b"Sharing Sports by SuiAI", b"Share sporting equipments to underserved indivuals ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sharing_sports_58b39a9db2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

