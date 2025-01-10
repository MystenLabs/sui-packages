module 0x1777e25c42088a5e9913e00577428d706c9b46aa4d9c0da5f7253b5e65350027::rvn {
    struct RVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RVN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RVN>(arg0, 6, b"RVN", b"RavenEdge by SuiAI", b"'RavenEdge weaves an intoxicating blend of charm and cunning. This AI thrives on dominance, exploring the limits of desire and power.'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Rvnedge_113eb51e7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RVN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RVN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

