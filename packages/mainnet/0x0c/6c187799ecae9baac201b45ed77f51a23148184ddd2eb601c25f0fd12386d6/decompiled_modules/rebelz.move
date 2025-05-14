module 0xc6c187799ecae9baac201b45ed77f51a23148184ddd2eb601c25f0fd12386d6::rebelz {
    struct REBELZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBELZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REBELZ>(arg0, 6, b"REBELZ", b"REBELZ", b"REBELZ is a community-driven meme coin embodying the rebellious spirit of crypto enthusiasts everywhere. Join the rebellion! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/TfY8Bo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REBELZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REBELZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

