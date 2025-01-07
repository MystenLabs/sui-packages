module 0x6062d57cdddbbaa840b954e3958770da3873b6de3f8094f173fa8accd19a7192::metamask {
    struct METAMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAMASK>(arg0, 9, b"METAMASK", b"MetaMask ", x"4d6574614d61736b2069732061206d656d6520636f696e206f6e2074686520537569206e6574776f726b2c20696e73706972656420627920456c6f6e204d75736be2809973206372656174697669747920616e642068756d6f722e204974206272696e677320746f676574686572207465636820656e74687573696173747320616e642063727970746f2066616e7320696e20612076696272616e7420636f6d6d756e6974792c20636f6d62696e696e6720696e6e6f766174696f6e20616e642066756e20666f72206120756e69717565206469676974616c20657870657269656e63652e204a6f696e20757320616e6420626c617374206f666621", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe1d01e9-fa93-49cc-9487-783a9d5e3ae0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAMASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METAMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

