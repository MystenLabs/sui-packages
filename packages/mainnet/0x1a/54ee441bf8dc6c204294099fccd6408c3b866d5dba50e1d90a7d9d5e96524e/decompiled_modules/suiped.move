module 0x1a54ee441bf8dc6c204294099fccd6408c3b866d5dba50e1d90a7d9d5e96524e::suiped {
    struct SUIPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPED>(arg0, 6, b"SUIPED", b"SuipedOnSui", b"$SUIPED - a meme token in the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000427_dc8753cd90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPED>>(v1);
    }

    // decompiled from Move bytecode v6
}

