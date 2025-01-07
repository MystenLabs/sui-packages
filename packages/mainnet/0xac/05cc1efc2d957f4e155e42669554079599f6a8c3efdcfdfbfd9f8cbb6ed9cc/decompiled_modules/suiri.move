module 0xac05cc1efc2d957f4e155e42669554079599f6a8c3efdcfdfbfd9f8cbb6ed9cc::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRI>(arg0, 6, b"SUIRI", b"Suiri", b"Embrace the charm of suiteness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Toasty_8024390df4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

