module 0x6fea78c719561ff4f342d38ac086b25a1d74cfe8f4a660c81132ebdeea1df9d0::vgl {
    struct VGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: VGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VGL>(arg0, 9, b"VGL", b"VERITAS GL", b"VERITAS is a video MONETISATION software that helps users earn from watching video contents either posted by them or by others with the help of their software.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4b2a3c6-dd1a-4d37-912d-abc0076a6d89.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

