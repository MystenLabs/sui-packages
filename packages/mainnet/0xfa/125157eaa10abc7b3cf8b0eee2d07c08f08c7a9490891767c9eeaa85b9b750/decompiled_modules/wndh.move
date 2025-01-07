module 0xfa125157eaa10abc7b3cf8b0eee2d07c08f08c7a9490891767c9eeaa85b9b750::wndh {
    struct WNDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNDH>(arg0, 9, b"WNDH", b"Windah", b"Windah Basudara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bca0623-c15f-49f3-86c0-450daf35cf54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

