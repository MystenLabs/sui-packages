module 0xc974b5c2acbc7afd073ea802f3371d7470b347ead1eb684e899d74780e50eea1::tehnx {
    struct TEHNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEHNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEHNX>(arg0, 9, b"TEHNX", b"isjdn", b"kdnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33ee423c-c2e4-4b2a-a089-aad4117004af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEHNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEHNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

