module 0x57d3549cd58fc3be111bb8c28c909788557d569a841d7e5d1bc4259aa5f0fb60::dogeus {
    struct DOGEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEUS>(arg0, 6, b"DOGEUS", b"DOGEUS MAXIMUS", b" The official invasion begins! $DOGEUS has landed  join the revolution now and claim your spot in history! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avarta_X_b380610185.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

