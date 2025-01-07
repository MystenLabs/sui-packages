module 0xd8a7e7e224b2dede6854025176bcd9ffd2aa6b53d91e8d037e8616a3570a8810::stalker {
    struct STALKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STALKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STALKER>(arg0, 9, b"STALKER", b"S.T.L.K.R.", b"fun token S. T. A. L. K. E. R. 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c1226a1-1fc0-4752-9f2f-011308427001.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STALKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STALKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

