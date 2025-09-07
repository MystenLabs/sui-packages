module 0xf928655f2a2e3c465fd2acee0e8e9670e4b27201211cafc65cc2c4d4c61f3b4::Tether {
    struct TETHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHER>(arg0, 9, b"TETHER", b"Tether", b"coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0PMQYGWsAAchNo?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

