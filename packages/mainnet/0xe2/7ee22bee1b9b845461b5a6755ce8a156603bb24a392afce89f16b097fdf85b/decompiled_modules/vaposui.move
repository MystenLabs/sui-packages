module 0xe27ee22bee1b9b845461b5a6755ce8a156603bb24a392afce89f16b097fdf85b::vaposui {
    struct VAPOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOSUI>(arg0, 6, b"VAPOSUI", b"Vaposui Pokemon Game", b"$VAPOSUI building pokemon ponzi game on Sui blockchain .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreift3jascuarwyqv36h2hgtn2iypaxv2niwgr4ptjmgd6c5pi7tw4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VAPOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

