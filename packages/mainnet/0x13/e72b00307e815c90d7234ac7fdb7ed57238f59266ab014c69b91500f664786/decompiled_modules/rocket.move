module 0x13e72b00307e815c90d7234ac7fdb7ed57238f59266ab014c69b91500f664786::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"Rocket", b"@suilaunchcoin @SuiAIFun @suilaunchcoin $ROCKET + Rocket https://t.co/Ry6Lu9XJAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rocket-q43a6u.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

