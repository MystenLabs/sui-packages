module 0xcfefc0f51bf73fbb9f1a9523a190d01aa48abd661e2a7a9c269f5cf8b16c2030::bigsui {
    struct BIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BIGSUI>(arg0, 6, b"BIGSUI", b"BigSui", b"BigSui is a fun meme coin that celebrates the legendary status of Big Suiren in the crypto community. Join the BigSui movement today! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/uwr75c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIGSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

