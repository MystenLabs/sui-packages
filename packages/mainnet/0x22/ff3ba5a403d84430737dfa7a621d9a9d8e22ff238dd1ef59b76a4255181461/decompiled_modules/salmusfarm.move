module 0x22ff3ba5a403d84430737dfa7a621d9a9d8e22ff238dd1ef59b76a4255181461::salmusfarm {
    struct SALMUSFARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMUSFARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMUSFARM>(arg0, 9, b"SALMUSFARM", b"Uba", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5db3ebf0-3e3a-4372-884b-4569512ec64e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMUSFARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALMUSFARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

