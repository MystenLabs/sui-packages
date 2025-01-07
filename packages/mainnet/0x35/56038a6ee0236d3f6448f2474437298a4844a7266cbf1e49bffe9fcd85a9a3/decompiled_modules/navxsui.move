module 0x3556038a6ee0236d3f6448f2474437298a4844a7266cbf1e49bffe9fcd85a9a3::navxsui {
    struct NAVXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVXSUI>(arg0, 6, b"NAVXSUI", b"NAVI SUI Protocol", b"Analysis of NAVI, the leading liquidity protocol on Sui: NAVX + Loan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/842_1706872447768_2ab157ea75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAVXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

