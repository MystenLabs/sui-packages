module 0x75b09864bb46119813e72aa7423e7cdb31d83672f716f2feb9c811f6e9abcddf::digirabbit {
    struct DIGIRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGIRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGIRABBIT>(arg0, 6, b"DIGIRABBIT", b"DIGIMON RABBIT", b"#DigimonRabbit is the most outstanding meme of Digimon Adventure series. This is the first attempt of digital monster NFT art. Trying STEALTH launch Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeialpc5uqnneiggeqlxfk3bzaiiduozvfkyqwxibzgynmpvg6zi77i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGIRABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIGIRABBIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

