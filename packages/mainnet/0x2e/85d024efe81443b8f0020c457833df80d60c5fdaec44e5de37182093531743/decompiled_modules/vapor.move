module 0x2e85d024efe81443b8f0020c457833df80d60c5fdaec44e5de37182093531743::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"Vaporware", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/JqQcpVK/favicon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VAPOR>>(0x2::coin::mint<VAPOR>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

