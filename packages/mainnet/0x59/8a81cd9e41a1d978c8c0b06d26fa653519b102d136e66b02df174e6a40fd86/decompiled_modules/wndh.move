module 0x598a81cd9e41a1d978c8c0b06d26fa653519b102d136e66b02df174e6a40fd86::wndh {
    struct WNDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDH>(arg0, 9, b"WNDH", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f840ade3-8083-4c0e-9117-c96bfc38760e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

