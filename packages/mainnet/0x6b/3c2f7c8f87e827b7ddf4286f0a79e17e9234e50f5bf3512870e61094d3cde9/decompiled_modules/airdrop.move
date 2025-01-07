module 0x6b3c2f7c8f87e827b7ddf4286f0a79e17e9234e50f5bf3512870e61094d3cde9::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 6, b"Airdrop", b"www.AtomWeb.at", b"Get ATOM Airdrop  visiting url: www.AtomWeb.at  - https://AtomWeb.at", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_98a2f22009.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

