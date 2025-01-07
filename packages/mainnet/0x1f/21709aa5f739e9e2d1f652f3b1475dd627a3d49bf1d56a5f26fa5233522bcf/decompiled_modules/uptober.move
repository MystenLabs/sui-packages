module 0x1f21709aa5f739e9e2d1f652f3b1475dd627a3d49bf1d56a5f26fa5233522bcf::uptober {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 9, b"UPTOBER", b"UpToberSui", x"245550544f42455220e2809320656e646c65737320626565722066756e20616e642062696720626f6f6273212057686174206d6f726520646f20796f75206e65656420666f722068617070696e6573733f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DhPxuySkehrLQpcLNAWHmBJtoBJigynHrTuBNcmmSJzF.png?size=xl&key=cd5f82")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UPTOBER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPTOBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

