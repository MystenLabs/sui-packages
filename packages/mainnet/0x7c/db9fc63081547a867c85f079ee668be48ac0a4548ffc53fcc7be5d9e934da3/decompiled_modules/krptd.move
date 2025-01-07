module 0x7cdb9fc63081547a867c85f079ee668be48ac0a4548ffc53fcc7be5d9e934da3::krptd {
    struct KRPTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRPTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRPTD>(arg0, 6, b"KRPTD", b"KRYPTANS.DAO", b"FOR FUN MY MATE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_14_at_18_56_54_ab27206709.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRPTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRPTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

