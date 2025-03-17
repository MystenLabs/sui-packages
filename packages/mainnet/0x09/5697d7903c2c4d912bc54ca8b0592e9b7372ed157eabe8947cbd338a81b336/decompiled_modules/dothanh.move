module 0x95697d7903c2c4d912bc54ca8b0592e9b7372ed157eabe8947cbd338a81b336::dothanh {
    struct DOTHANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTHANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTHANH>(arg0, 9, b"DOTHANH", b"Baki", b"Baki super", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ea6bf00-ea82-48ab-9e8c-e8a44233e261.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTHANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTHANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

