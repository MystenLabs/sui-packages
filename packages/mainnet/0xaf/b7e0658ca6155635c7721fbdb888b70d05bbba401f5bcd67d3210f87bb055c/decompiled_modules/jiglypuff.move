module 0xafb7e0658ca6155635c7721fbdb888b70d05bbba401f5bcd67d3210f87bb055c::jiglypuff {
    struct JIGLYPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGLYPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGLYPUFF>(arg0, 6, b"JIGLYPUFF", b"JIGGLYPUFF", b"Jigglypuff - the cutest singing Pokemon. She's here to entertain everyone who loves Pokemon and $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiemi5653n6qyoaklgyu6rxnijy3omut2ljtnxbympqn3bs4rfuffe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGLYPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGLYPUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

