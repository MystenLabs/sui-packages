module 0x7eee20558200df4d74da8e2625d66092fb4ed3e31cf38d147cbdcc0e0edd7552::ducks {
    struct DUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKS>(arg0, 6, b"DUCKS", b"DUCKING SUI", b"DUCK IS DUCKING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9db3fa7731d860f48973ba52c3b2eea5_a46a369aff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

