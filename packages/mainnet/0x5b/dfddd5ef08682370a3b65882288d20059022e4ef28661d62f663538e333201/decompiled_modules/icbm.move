module 0x5bdfddd5ef08682370a3b65882288d20059022e4ef28661d62f663538e333201::icbm {
    struct ICBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICBM>(arg0, 6, b"ICBM", b"Intercontinental Ballistic Missile", b"Intercontinental Ballistic Missile Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/inbound_icbm_vector_68580_c8b5fbe09b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICBM>>(v1);
    }

    // decompiled from Move bytecode v6
}

