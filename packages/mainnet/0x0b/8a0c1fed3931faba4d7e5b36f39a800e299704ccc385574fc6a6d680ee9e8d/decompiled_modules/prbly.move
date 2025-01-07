module 0xb8a0c1fed3931faba4d7e5b36f39a800e299704ccc385574fc6a6d680ee9e8d::prbly {
    struct PRBLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRBLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRBLY>(arg0, 6, b"PRBLY", b"Probably Nothing", b"Probably Nothing (PRBLY) is a cryptocurrency project that began as a meme coin and is evolving into a community-driven initiative aiming to transition into a web3 tech company. The project emphasizes decentralization, security, and transparency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732909627610.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRBLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRBLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

