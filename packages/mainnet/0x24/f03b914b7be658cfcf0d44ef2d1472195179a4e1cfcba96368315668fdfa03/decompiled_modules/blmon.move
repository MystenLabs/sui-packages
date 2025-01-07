module 0x24f03b914b7be658cfcf0d44ef2d1472195179a4e1cfcba96368315668fdfa03::blmon {
    struct BLMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLMON>(arg0, 6, b"BlMon", b"The Blue Monkey", b"the blue monkey to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d5a09683_9515_485b_889f_f4d624ae752d_3ab3d40e81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

