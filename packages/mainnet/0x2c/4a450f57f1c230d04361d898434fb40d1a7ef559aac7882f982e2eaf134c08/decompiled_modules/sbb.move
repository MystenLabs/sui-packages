module 0x2c4a450f57f1c230d04361d898434fb40d1a7ef559aac7882f982e2eaf134c08::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 6, b"SBB", b"SUI BLOCKCHAIN BULL", b"THE SUI MASCOT HAS ARRIVED ON MOVE PUMP. DEDICATED DEV WITH AN ACTIVE NFT LAUNCH! THE FIRST 50 NFTS ARE 1 SUI AND IF YOU GET THE \"TRUMP BULL SUI DIAMOND NECKLACE\"  BRUNOAILABS WILL SEND YOU 5 SUI TO YOUR WALLET YOU MINTED WITH! LETS PLAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/548_151d993715.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

