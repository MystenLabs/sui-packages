module 0x39901d16c8f633c5af2b8bcbd5cae3109506f33fd92cd164b617f57b9c2c9ad1::lbb2 {
    struct LBB2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBB2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBB2>(arg0, 6, b"LBB2", b"labubu", b"labubu is cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750844231332.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBB2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBB2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

