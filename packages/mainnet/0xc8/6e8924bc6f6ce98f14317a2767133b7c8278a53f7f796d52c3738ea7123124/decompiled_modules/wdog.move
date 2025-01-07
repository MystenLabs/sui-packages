module 0xc86e8924bc6f6ce98f14317a2767133b7c8278a53f7f796d52c3738ea7123124::wdog {
    struct WDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOG>(arg0, 6, b"wDOG", b"WrappedDog", b"Unwrap your dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wdog_8b13481e37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

