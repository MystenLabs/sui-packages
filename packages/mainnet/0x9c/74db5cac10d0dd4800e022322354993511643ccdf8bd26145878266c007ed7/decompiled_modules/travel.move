module 0x9c74db5cac10d0dd4800e022322354993511643ccdf8bd26145878266c007ed7::travel {
    struct TRAVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAVEL>(arg0, 6, b"TRAVEL", b"Travel Frog", b"The first Ai Adventure Versus Game with the model of \"Travel to Earn\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042483_bdad5d17d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAVEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAVEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

