module 0x569dab1d3b4e0ee8eff23a650f94c888f53578c9929aa1cbfdf7a44ed7afffd2::wcar {
    struct WCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAR>(arg0, 9, b"WCAR", b"WIZARD CAR", x"205741564520f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f07a80c-2708-40bd-9611-530398c69aa5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

