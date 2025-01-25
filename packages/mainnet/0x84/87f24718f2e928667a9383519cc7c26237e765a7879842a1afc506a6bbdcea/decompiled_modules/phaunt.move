module 0x8487f24718f2e928667a9383519cc7c26237e765a7879842a1afc506a6bbdcea::phaunt {
    struct PHAUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHAUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHAUNT>(arg0, 6, b"PHAUNT", b"Phauntem On Sui", b"Phauntem the Phantom MEME is here, bringing Solana's most beloved ghost to the SUI network. Get ready for the floodgates to open, because millions of users are about to join the fun. Its spooky, its meme-worthy, and its ready to take overPhantom just leveled up!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logodexs1_6_1_9492721b63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHAUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHAUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

