module 0x4626727978c3b4ca344131a7d65ffc2cf990994982f43462e60be84fdf57ce49::tonkeee {
    struct TONKEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONKEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONKEEE>(arg0, 9, b"TONKEEE", b"TONKEEE", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TONKEEE>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONKEEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONKEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

