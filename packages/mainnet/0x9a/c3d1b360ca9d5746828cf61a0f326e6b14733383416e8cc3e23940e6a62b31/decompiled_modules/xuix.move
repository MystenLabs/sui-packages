module 0x9ac3d1b360ca9d5746828cf61a0f326e6b14733383416e8cc3e23940e6a62b31::xuix {
    struct XUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUIX>(arg0, 9, b"XUIX", b"XUI", b"UX/UI designer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ead0a66c-ae5d-4f30-9659-1cc2a5c10cd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

