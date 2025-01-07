module 0xef0369dd0f0b42731bc88601ad256bfe8189980d2ba512a1148c6244eaaa2c5e::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 6, b"AIRDROP", b"sui airdrop", b"no probably nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_nh2_beeddb729d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

