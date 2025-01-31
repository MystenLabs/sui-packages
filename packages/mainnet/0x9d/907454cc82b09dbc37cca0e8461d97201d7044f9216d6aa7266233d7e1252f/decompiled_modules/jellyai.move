module 0x9d907454cc82b09dbc37cca0e8461d97201d7044f9216d6aa7266233d7e1252f::jellyai {
    struct JELLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLYAI>(arg0, 9, b"JELLYAI", b"JELLY JELLY A.I", b"JELLY JELLY A.I ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT6Ps5DtEkZBjvic3Qti3m9bW6EQ84B9FDJE6NP8pU9t7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLYAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLYAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLYAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

