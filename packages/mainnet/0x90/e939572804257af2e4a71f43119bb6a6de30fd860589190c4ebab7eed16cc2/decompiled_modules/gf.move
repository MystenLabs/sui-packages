module 0x90e939572804257af2e4a71f43119bb6a6de30fd860589190c4ebab7eed16cc2::gf {
    struct GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF>(arg0, 6, b"GF", b"Girlfriend", b"Girl Dev, Livestream at King Of Sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_62bece6fb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GF>>(v1);
    }

    // decompiled from Move bytecode v6
}

