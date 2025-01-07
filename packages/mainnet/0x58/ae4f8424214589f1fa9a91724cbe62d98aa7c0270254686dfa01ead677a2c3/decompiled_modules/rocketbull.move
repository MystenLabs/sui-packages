module 0x58ae4f8424214589f1fa9a91724cbe62d98aa7c0270254686dfa01ead677a2c3::rocketbull {
    struct ROCKETBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKETBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKETBULL>(arg0, 6, b"RocketBull", b"Rocket Bull ON SUI", b"Bull Run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Ev_F4n_WAAAX_Qn_G_809d4b995d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKETBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKETBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

