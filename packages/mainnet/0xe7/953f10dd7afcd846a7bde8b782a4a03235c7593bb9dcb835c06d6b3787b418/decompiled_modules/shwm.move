module 0xe7953f10dd7afcd846a7bde8b782a4a03235c7593bb9dcb835c06d6b3787b418::shwm {
    struct SHWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHWM>(arg0, 9, b"SHWM", b"Shawarma ", b"A memecoin for all food lovers around the world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c2a105b-962a-4540-ad24-1627d1ba6c8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

