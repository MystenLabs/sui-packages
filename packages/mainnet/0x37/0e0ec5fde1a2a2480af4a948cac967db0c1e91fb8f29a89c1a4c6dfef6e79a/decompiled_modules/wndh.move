module 0x370e0ec5fde1a2a2480af4a948cac967db0c1e91fb8f29a89c1a4c6dfef6e79a::wndh {
    struct WNDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDH>(arg0, 9, b"WNDH", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a510f794-66c1-4ccf-b400-4b2e7c08112a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

