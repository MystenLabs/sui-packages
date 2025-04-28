module 0x3fb9570f2c59b31634e80ab86d50b66480a1727d4d673409f15a40654adc365::bugzy {
    struct BUGZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGZY>(arg0, 6, b"BUGZY", b"Weird Bugzy", x"5765697264204255475a592c2074686572652069732061207765697264206275677a79206f6e206d6f766570756d702c20706c656173652068656c700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bugzy_logo_54ce0cb6f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUGZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

