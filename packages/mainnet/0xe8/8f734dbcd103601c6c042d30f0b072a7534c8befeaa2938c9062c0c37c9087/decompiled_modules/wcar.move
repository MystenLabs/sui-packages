module 0xe88f734dbcd103601c6c042d30f0b072a7534c8befeaa2938c9062c0c37c9087::wcar {
    struct WCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAR>(arg0, 9, b"WCAR", b"W CAR", b"WCAR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dc91e12-a3eb-4542-b0aa-4c5cd515943d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

