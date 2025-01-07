module 0x1d9216cb0ffc03d96a059feeb59728381f2f4a24d83c065450441edb0047e561::vinhvinh {
    struct VINHVINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINHVINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINHVINH>(arg0, 9, b"VINHVINH", b"Vinhle", b"Vinhlele", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f1af074-a409-4580-91f7-497e0e2656c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINHVINH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINHVINH>>(v1);
    }

    // decompiled from Move bytecode v6
}

