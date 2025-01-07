module 0x3c772f2631a618d5042e4b572cea3a5b6dee5b3ad0cb398b44a832e2f0e918a4::TINI {
    struct TINI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TINI>, arg1: 0x2::coin::Coin<TINI>) {
        0x2::coin::burn<TINI>(arg0, arg1);
    }

    fun init(arg0: TINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINI>(arg0, 9, b"TINI", b"Tini World", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/RpD1VW5/tini.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TINI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TINI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

