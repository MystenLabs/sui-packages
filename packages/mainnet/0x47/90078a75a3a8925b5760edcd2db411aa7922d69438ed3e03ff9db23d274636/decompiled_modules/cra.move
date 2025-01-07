module 0x4790078a75a3a8925b5760edcd2db411aa7922d69438ed3e03ff9db23d274636::cra {
    struct CRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRA>(arg0, 9, b"CRA", b"CARS", x"5769746820434152204d656d65636f696e2c2061206469676974616c2063757272656e637920746861742063656c656272617465732074686520737069726974206f6620746865206f70656e20726f61640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18989f8d-a1b7-42f5-b1a6-666cc7181e06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

