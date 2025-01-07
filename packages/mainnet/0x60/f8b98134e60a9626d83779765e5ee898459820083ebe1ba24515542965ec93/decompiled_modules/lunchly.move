module 0x60f8b98134e60a9626d83779765e5ee898459820083ebe1ba24515542965ec93::lunchly {
    struct LUNCHLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNCHLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCHLY>(arg0, 6, b"LUNCHLY", b"Lunchly on SUI", b"Lunchly Fan Account.Not Affiliated with KSI,Logan,Mr.Beast!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s5wbv_Gvi_400x400_ba541eb3b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNCHLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNCHLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

