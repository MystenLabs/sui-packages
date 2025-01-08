module 0xa1ae3fb8670a185d954a7a2b74376e161195eb8d032ff49bd0887963b2547a13::bolex {
    struct BOLEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLEX>(arg0, 9, b"BOLEX", b"Boluwatife", b"Strong fundamentals and innovation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa420bd7-11fb-4d88-91c0-92bc294c2543.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOLEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

