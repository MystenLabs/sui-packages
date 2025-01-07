module 0xbbf9a367c954bb32f3634d6a73303fc667ae55c67f36653c835dcb7b193873a8::wewepumpit {
    struct WEWEPUMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEPUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEPUMPIT>(arg0, 9, b"WEWEPUMPIT", b"Wpump", b"Am bullish on WEWE token about to be launched on Sui Blockchain,am so exicted,it is going to be massive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42ba3505-494f-460c-bc35-4414dbf7d8ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEPUMPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEPUMPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

