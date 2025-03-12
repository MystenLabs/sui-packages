module 0xe58293f931f4e48efb841f2c2bb296c5dcf93b897d484cb6d438b7d940e9f701::heheh {
    struct HEHEH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHEH>(arg0, 9, b"HEHEH", b"Heheh Token", b"A token for fun and laughter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEHEH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEHEH>>(v1);
    }

    // decompiled from Move bytecode v6
}

