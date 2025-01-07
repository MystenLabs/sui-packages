module 0xe82c949883205c977172863972644d18733f17878a736296af3022583c3a9387::drops {
    struct DROPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPS>(arg0, 9, b"DROPS", b"Drop", b"Drops token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87063109-f10d-4580-af9c-e1ab89b05dc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

