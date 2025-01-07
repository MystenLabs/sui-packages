module 0x877779bc1b3b02b16e6bf48e9fa00774d3ff9c04b6ac304acd03169a93f2b4e2::suibolt {
    struct SUIBOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOLT>(arg0, 6, b"Suibolt", b"debolt", b"an influence of americam government divert and create a meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002171_23234c7c66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

