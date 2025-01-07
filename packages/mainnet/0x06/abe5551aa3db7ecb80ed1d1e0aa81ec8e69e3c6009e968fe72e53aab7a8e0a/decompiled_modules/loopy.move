module 0x6abe5551aa3db7ecb80ed1d1e0aa81ec8e69e3c6009e968fe72e53aab7a8e0a::loopy {
    struct LOOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOPY>(arg0, 9, b"LOOPY", b"Loopy", b"Loopy : The Most Adorable cult to ever invade SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43257bf0-b57e-4e0e-bedd-414e76bfa0f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

