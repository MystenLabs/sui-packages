module 0xb95412f8840bc36510ee804d8655fa022c0e4d6b6ccc4832ddd6a580ad1c7283::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLO>(arg0, 6, b"CARLO", b"carlo dog SUI", b"A psycho dog with a pink asshole coming to drag his balls all over SIU.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carlo_1_619fba9415.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

