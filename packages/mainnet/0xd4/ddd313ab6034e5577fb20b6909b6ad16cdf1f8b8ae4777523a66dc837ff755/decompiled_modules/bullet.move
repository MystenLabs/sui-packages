module 0xd4ddd313ab6034e5577fb20b6909b6ad16cdf1f8b8ae4777523a66dc837ff755::bullet {
    struct BULLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLET>(arg0, 6, b"BULLET", b"AIBULLET by SuiAI", b"$BULLET AI Agent |..$BULLET is the champion bull of the .SUI Chain..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4h_Hz_PM_Ne_400x400_d308674047.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

