module 0x979daa5221e7a703e17d781bfec21fe69c47d689d3f294602b9e14fb888f418a::sumosui {
    struct SUMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMOSUI>(arg0, 6, b"SUMOSUI", b"SUMO SUI", b"The SUMO girl Sui. She looking for a nice swim with the whale's. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024947_a0be627c2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

