module 0x31fc4e87dd0f187d3b898c15819965928b495e4781bd1f4cd83b2933715d1d2::venko {
    struct VENKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VENKO>(arg0, 6, b"VENKO", b"Venko", b"@suilaunchcoin @SuiAIFun @suilaunchcoin  $VENKO + Venko Alien https://t.co/tmAEtuSiSv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/venko-77cawx.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VENKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

