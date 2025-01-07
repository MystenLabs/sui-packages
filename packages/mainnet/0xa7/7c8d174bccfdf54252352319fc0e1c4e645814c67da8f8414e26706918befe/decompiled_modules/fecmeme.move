module 0xa77c8d174bccfdf54252352319fc0e1c4e645814c67da8f8414e26706918befe::fecmeme {
    struct FECMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: FECMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FECMEME>(arg0, 9, b"FECMEME", b"fecmobi", b"FECMEME Update", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/359f32ba-ad4d-4113-85c9-a9ed0ed33449.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FECMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FECMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

