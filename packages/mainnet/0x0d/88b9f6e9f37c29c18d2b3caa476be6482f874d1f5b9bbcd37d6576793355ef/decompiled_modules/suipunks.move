module 0xd88b9f6e9f37c29c18d2b3caa476be6482f874d1f5b9bbcd37d6576793355ef::suipunks {
    struct SUIPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUNKS>(arg0, 9, b"suipunks", b"Sui Punks NFT", b"SUIPUNKS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.bluemove.io/uploads/sui-punks/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPUNKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUNKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

