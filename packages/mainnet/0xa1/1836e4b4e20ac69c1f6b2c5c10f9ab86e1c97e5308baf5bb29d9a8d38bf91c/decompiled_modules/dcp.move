module 0xa11836e4b4e20ac69c1f6b2c5c10f9ab86e1c97e5308baf5bb29d9a8d38bf91c::dcp {
    struct DCP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCP>(arg0, 6, b"DCP", b"DBL Cheese Purrr'ger (Cheepurr)", b"Nourish to Flourish! $CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012508_49efedc76d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCP>>(v1);
    }

    // decompiled from Move bytecode v6
}

