module 0xf8ed3ecb1e6f5ae1f551224f7bc424c51281148896ef43a063880524d08022bc::jinbe {
    struct JINBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINBE>(arg0, 6, b"JINBE", b"$JINBE first son of the SUI", b"$Jinbe, the First Son of the Sea, dives into the Sui ecosystem. Riding the crypto waves and protecting the blockchain shores. Hes the whale you want on your side!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037206_88359ecd5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

