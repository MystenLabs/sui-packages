module 0xa2e4379db9ed77f42b4553fc8727eee2076610b2be764a585f62fbae3361d817::pms {
    struct PMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMS>(arg0, 6, b"PMS", b"PacMoon SUI", b"Devs abandoned  PACMOON $PAC on blast. Community is bringing it back on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pacmon_a93bcece4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

