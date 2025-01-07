module 0x8c349e1ad9d3831396c5cac9d3137016111b4f9297454e155e008f62d866101d::wiii {
    struct WIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIII>(arg0, 9, b"WIII", b"WIWI", b"Stoners ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61c90e5c-73df-46c9-9a9f-ff535d378e70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

