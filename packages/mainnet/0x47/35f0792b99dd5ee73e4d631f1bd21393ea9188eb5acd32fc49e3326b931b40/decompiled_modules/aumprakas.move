module 0x4735f0792b99dd5ee73e4d631f1bd21393ea9188eb5acd32fc49e3326b931b40::aumprakas {
    struct AUMPRAKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUMPRAKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUMPRAKAS>(arg0, 9, b"AUMPRAKAS", b"Aum", b"Cerypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/958f8c5a-7763-46ea-9eeb-38fe1a3db7af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUMPRAKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUMPRAKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

