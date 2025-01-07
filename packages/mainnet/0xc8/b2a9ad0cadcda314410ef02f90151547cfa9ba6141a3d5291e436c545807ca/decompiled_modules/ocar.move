module 0xc8b2a9ad0cadcda314410ef02f90151547cfa9ba6141a3d5291e436c545807ca::ocar {
    struct OCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCAR>(arg0, 9, b"OCAR", b"Orange Car", b"Just an orange car", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1495770b-d0f2-45b1-81cf-7cdca77dff10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

