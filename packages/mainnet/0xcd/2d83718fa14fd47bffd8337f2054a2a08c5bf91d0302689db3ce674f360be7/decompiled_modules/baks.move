module 0xcd2d83718fa14fd47bffd8337f2054a2a08c5bf91d0302689db3ce674f360be7::baks {
    struct BAKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKS>(arg0, 6, b"BAKS", b"BAK$COIN", b"don't go to the plug without having a swug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bakscoin_7400d19ced.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

