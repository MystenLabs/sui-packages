module 0xa57d607503c56f794c2ed32700204aa2904b79145985a7017b4dc0af77c3bb3a::underg {
    struct UNDERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDERG>(arg0, 9, b"UNDERG", b"UG", b"Under Ground", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95e53443-c543-44ae-bbe9-3565fde871fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDERG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNDERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

