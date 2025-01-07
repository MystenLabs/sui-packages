module 0x1d3c41a3af5c0d5b2289b9f7242aa81fb0411b48701ae74ea5bd36c145859b22::soul {
    struct SOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOUL>(arg0, 9, b"SOUL", b"Soul Token", b"Ahhh, i'm witch bro! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ee7c822-8734-4da9-abde-a1fa0f0af377.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

