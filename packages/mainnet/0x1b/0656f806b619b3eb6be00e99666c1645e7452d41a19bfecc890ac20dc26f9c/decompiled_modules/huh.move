module 0x1b0656f806b619b3eb6be00e99666c1645e7452d41a19bfecc890ac20dc26f9c::huh {
    struct HUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUH>(arg0, 9, b"HUH", b"MAP", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2dea5608-7c70-49e1-b695-6701c741b181.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

