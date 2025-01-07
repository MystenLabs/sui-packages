module 0x6413152dc15c8b87a5ca6ba606c09103e9ba9c5c369fc6389e0bb76e617a728e::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 9, b"LABU", b"LABUBU", b"Token inspired by the animated film Labubu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8b75ac0-24c8-4983-968d-16c9b2fe52ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

