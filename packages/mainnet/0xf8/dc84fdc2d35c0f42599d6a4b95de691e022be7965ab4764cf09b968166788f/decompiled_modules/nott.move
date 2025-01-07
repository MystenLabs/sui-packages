module 0xf8dc84fdc2d35c0f42599d6a4b95de691e022be7965ab4764cf09b968166788f::nott {
    struct NOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTT>(arg0, 6, b"NOTT", b"Nothing on Sui", x"4e6f7420736f6369616c200a4e6f742074656c656772616d0a436f6d6d756e6974792068616e646c6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029217_cb60071dcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

