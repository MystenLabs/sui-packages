module 0x3680921ac0086c96c58e7153333260cad6e99071e05cdf691af5500f96fb5e77::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"TREMP", b"Doland J Tremp", b"Leader Of The New World Order.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003534_8008470c7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

