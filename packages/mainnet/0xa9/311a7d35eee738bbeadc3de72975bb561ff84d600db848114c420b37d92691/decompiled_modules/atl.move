module 0xa9311a7d35eee738bbeadc3de72975bb561ff84d600db848114c420b37d92691::atl {
    struct ATL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATL>(arg0, 6, b"ATL", b"ATLANTIS AGENT", b"$ATL is rising from the $SUI Network to bridge Past and Future. An AI Agent from the legendary city of Atlantis. Dive into the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_ATLANTIS_AGENT_65a682c215.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATL>>(v1);
    }

    // decompiled from Move bytecode v6
}

