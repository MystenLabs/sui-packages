module 0x748d1048e6df8095c695749bcdd7b29b52f4d6bfced4d25112c4fa61fe720d21::vdgfgfgfgf {
    struct VDGFGFGFGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDGFGFGFGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDGFGFGFGF>(arg0, 9, b"VDGFGFGFGF", b"kjkjkj", b"HGHGHG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e89fc21-8408-49c5-96c0-e24f8948de69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDGFGFGFGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VDGFGFGFGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

