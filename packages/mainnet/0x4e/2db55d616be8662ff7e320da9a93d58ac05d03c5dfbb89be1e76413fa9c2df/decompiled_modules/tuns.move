module 0x4e2db55d616be8662ff7e320da9a93d58ac05d03c5dfbb89be1e76413fa9c2df::tuns {
    struct TUNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNS>(arg0, 6, b"Tuns", b"Tuncays", b"only for human", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lolita_26222606c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

