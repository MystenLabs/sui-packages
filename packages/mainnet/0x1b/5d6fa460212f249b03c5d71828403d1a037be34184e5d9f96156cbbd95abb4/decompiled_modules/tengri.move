module 0x1b5d6fa460212f249b03c5d71828403d1a037be34184e5d9f96156cbbd95abb4::tengri {
    struct TENGRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENGRI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TENGRI>(arg0, 6, b"TENGRI", b"Tengri", b"@suilaunchcoin $TENGRI + Tengri https://t.co/eCC5UiO3JX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tengri-cumbds.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TENGRI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENGRI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

