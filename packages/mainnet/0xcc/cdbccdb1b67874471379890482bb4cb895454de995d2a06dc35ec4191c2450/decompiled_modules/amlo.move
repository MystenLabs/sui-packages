module 0xcccdbccdb1b67874471379890482bb4cb895454de995d2a06dc35ec4191c2450::amlo {
    struct AMLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMLO>(arg0, 9, b"AMLO", b"AMLO COIN", b"Andres Manuel Lopez Obrador", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AMLO>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMLO>>(v2, @0x5667e6959a819387e527fecc413ec83e3b3ecbd2fbb8c0640cfda044bdfb8fa7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

