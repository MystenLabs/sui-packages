module 0x953bf484a67f1a5424b68f082b3a2900be313a7d5661d6a278dd000f3603d655::poopie {
    struct POOPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPIE>(arg0, 6, b"Poopie", b"Sui Poopie", b"your favorite lil poopie. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731807329670.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POOPIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

