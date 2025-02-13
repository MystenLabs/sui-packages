module 0x87e444aaf21f2d82578d89a63a993d038433bbd2662d6dcaf174cdf8a9db404b::blki {
    struct BLKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLKI>(arg0, 6, b"BLKI", b"Bloki Ranger", x"546865204b6565706572206f662059616b2056696c6c6167650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BL_Ki_01_01_31575ea935.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

