module 0xf0c866ba411a2271e66f9f421c10e1ac0149dc8003b8e9bcac0dd90f8c820994::mizone {
    struct MIZONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZONE>(arg0, 9, b"MIZONE", b"Mizone SUI", b"Mizone in here.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27ac4f07-70ac-4c76-aca5-bf88da5639a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

