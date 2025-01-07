module 0x2560c08c203f5137286ecdf7bf4d42ed24e9f979884ef0a459510e085e6a022f::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"Fisherman", b"Chill fisherman", b"A fisherman with an ambition of catching whales on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_W9_QMZ_400x400_c395dc2e32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

