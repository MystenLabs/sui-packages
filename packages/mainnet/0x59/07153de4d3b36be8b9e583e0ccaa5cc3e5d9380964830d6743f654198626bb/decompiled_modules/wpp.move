module 0x5907153de4d3b36be8b9e583e0ccaa5cc3e5d9380964830d6743f654198626bb::wpp {
    struct WPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPP>(arg0, 9, b"WPP", b"WEWEPUMP", b"Wewepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf2d219b-7d8e-4979-ba43-feb416b1d27a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

