module 0x4550ff05a9396e80d7d210df7e753e136c524a99d388e5afb9f67dfd40e6ec9f::weweiiii {
    struct WEWEIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEIIII>(arg0, 9, b"WEWEIIII", b"Weweiii", b"Weweiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/440f703d-1008-4898-966c-07b790368958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

