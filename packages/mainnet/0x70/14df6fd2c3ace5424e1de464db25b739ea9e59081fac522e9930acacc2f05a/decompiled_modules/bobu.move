module 0x7014df6fd2c3ace5424e1de464db25b739ea9e59081fac522e9930acacc2f05a::bobu {
    struct BOBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBU>(arg0, 6, b"BOBU", b"BOBU ON SUI", b"The most adorable orca on WATER CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241002_233220_446_cbe511918f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

