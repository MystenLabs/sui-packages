module 0x5dbcb4988b1544ad3974d962861438d281532b3b0d3924cd20a2faa665af5b62::trumpe {
    struct TRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPE>(arg0, 9, b"TRUMPE", b"Trump MP3", b"Trump MP3 is about bringing new entertainment to the blockchain. We are starting a totally new meme narrative. Trump MP3 is revolutionizing the world of digital currency by combining the power of audio, memes, and blockchain technology into a unique and fun experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ton/eqalxsx5yxfttposlebccdrwtyzvc48nbrrjyccucoghyffs.png?size=lg&key=0162df")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPE>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPE>>(v2, @0xd7c8886f3dcce1c0f0602f61b9202cf50feb90b81310847c7e284290a0c75ad9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

