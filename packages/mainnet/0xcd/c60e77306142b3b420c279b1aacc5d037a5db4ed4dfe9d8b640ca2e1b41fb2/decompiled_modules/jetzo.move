module 0xcdc60e77306142b3b420c279b1aacc5d037a5db4ed4dfe9d8b640ca2e1b41fb2::jetzo {
    struct JETZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JETZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JETZO>(arg0, 9, b"JETZO", b"JETZO ON SUI", b"Jetzo is a high-speed, risk-loving force of naturefast enough to leave everyone in the dust and bold enough to make degenerate bets without a second thought. Website: https://jetzo.xyz/ Twitter URL: https://x.com/JetzoSOL Telegram URL: https://t.me/jetzochannel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tokenjungle.mypinata.cloud/ipfs/QmNhPGCBZJX7otAYsoEwrTkLxxSQjzeDv25uZxKwvDTX7Q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JETZO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JETZO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JETZO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

