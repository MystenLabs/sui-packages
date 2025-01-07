module 0x49a5f237466dcbb55d2d4c494284a8935e9076968b3406d4665768262edfc0ea::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASH>(arg0, 6, b"SMASH", b"The Smash Guy", b"This coin is dedicated to the famous Smash Guy aka - The hatched wielding hitchhiker - (watch it on Netflix). This coin is for all those , who believe in the good in people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kai_the_Hatchet_Wielding_Hitchhiker_a699deeb66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

