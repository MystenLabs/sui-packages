module 0x59af8526754fa0b4bb6d2d8ac7533c6667fb0803c5c1bd0e71208a04305321ce::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 9, b"LAIKA", b"Laika Dog", x"f09f90b6204c61696b612c2054686520466972737420446f6720646973636f76657265642074686520737061636520696e2074686520776f726c642e2053686520666c657720696e746f20746865207370616365206f6e2068657220736869702c20f09f9a8020537075746e696b20322c206f6e204e6f76656d626572203372642e2c20313935372e20f09faa99204c41494b412069732072656d656d6272616e636520616e642073696e63657265207468616e6b7320746f204c61696b6120616e6420486572204772656174205361637269666963652e205765206c6f766520596f7520666f7265766572204c61696b612054686520537061636520446f6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13e53bf8-8107-431d-ac14-18abf35143d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

