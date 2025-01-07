module 0xfa2249c2c9ce06df979fdbbda4e43ef851a4a346b673a7db1b621d19ab769ae6::swukkng {
    struct SWUKKNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWUKKNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWUKKNG>(arg0, 6, b"SWUKKNG", b"WUKUONG", b"Goku carries an extraordinary mission, and our tokens also need to be built differently by you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012750_73ad0874ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWUKKNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWUKKNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

