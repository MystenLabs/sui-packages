module 0xbc540ca32e3a46471fb10bdf906533e3f6ed044da011a82bc5d0874b52c1a45e::wangsui {
    struct WANGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGSUI>(arg0, 6, b"WANGSUI", b"WANGWANG", b"$WANGSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_KHPN_7_I2_400x400_e7b743917a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

