module 0x80a2d6360197e4e656a00dd837f39bb98b30a66e5952ae9a19f0f09cf6bf461a::vdfrg {
    struct VDFRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDFRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDFRG>(arg0, 9, b"VDFRG", b"Drtyh", b"ssdgf hdgr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c0de12a-8de2-4634-8dc9-80d38c4c089a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDFRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VDFRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

