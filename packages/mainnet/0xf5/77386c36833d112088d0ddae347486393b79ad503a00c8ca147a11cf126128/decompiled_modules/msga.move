module 0xf577386c36833d112088d0ddae347486393b79ad503a00c8ca147a11cf126128::msga {
    struct MSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGA>(arg0, 6, b"MSGA", b"MakeSUIGreatAgain", b"MSGA, a bonding memecoin to showing people how they are powerfull on SUI Network. Join the movement of Make SUI Great Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737467932437.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

