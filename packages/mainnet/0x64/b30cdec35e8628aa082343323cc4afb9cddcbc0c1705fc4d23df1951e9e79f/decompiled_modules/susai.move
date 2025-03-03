module 0x64b30cdec35e8628aa082343323cc4afb9cddcbc0c1705fc4d23df1951e9e79f::susai {
    struct SUSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUSAI>(arg0, 6, b"SUSAI", b"SUSAI by SuiAI", b"Due to market conditions, SUI now identifies as SUSAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/susai1_87cfa18d2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

