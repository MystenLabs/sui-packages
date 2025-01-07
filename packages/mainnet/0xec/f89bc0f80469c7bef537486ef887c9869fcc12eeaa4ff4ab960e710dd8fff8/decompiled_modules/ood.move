module 0xecf89bc0f80469c7bef537486ef887c9869fcc12eeaa4ff4ab960e710dd8fff8::ood {
    struct OOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOD>(arg0, 9, b"OOD", b"OODDDA", b"Aonaaw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aeb56cb7-166e-4cf5-b00c-050a94c0eca5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

