module 0xf9f0c80dfbff2d8b31406d9e27ba2aa0cd9baa43dbdeb7584055d876d1e03056::wndh {
    struct WNDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDH>(arg0, 9, b"WNDH", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/622d6a16-4267-4e22-8108-a8fa1f259c38.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

