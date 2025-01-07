module 0x8dde480c67da484a222650f2f2c4cfde95dc73be61e02ed7853c164469b1c072::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 9, b"PEPI", b"PEPE SUI", b"no description, just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e09257e0-176c-4980-b259-b849660f897f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

