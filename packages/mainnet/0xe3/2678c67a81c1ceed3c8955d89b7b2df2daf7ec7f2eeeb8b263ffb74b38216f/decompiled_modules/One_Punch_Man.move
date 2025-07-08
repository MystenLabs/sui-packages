module 0xe32678c67a81c1ceed3c8955d89b7b2df2daf7ec7f2eeeb8b263ffb74b38216f::One_Punch_Man {
    struct ONE_PUNCH_MAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE_PUNCH_MAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE_PUNCH_MAN>(arg0, 9, b"OPM", b"One Punch Man", b"strong punch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3edb7d4e-e5b2-45dc-bc55-5ba75c2efaee.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE_PUNCH_MAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE_PUNCH_MAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

