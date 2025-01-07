module 0x1d9a3501922f04b3d33303359338912befdd414325af26965879a508e0a9e1de::suiro {
    struct SUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRO>(arg0, 6, b"SUIRO", b"Sui Poro", x"546865206869707065737420746967657220796f75276c6c2065766572206d6565742e20466f72676574206c75726b696e6720696e2077657420666f7265737420e280932074686973206269672063617420676f742061206d6561646f7720616e64206120736572696f75732063617365206f6620746865206368696c6c732028696e2074686520626573742077617920706f737369626c652c206f627673292e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986816255.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

