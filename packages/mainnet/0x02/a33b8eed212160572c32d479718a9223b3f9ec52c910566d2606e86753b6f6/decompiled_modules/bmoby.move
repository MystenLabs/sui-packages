module 0x2a33b8eed212160572c32d479718a9223b3f9ec52c910566d2606e86753b6f6::bmoby {
    struct BMOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOBY>(arg0, 9, b"BMOBY", b"Baby Moby", b"Hi, Im Baby Moby! My dad, says I havent fully evolved yetand thats okay! Im still small, adorable, and have plenty of time to grow. Unlike my dad, who shines in the AI world, Ive chosen my own path as a meme token full of fun and laughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma4QewVM6g72E56ZUnDZsSbCuA3FFKgd3uSPdy7ju9t9s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BMOBY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMOBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOBY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

