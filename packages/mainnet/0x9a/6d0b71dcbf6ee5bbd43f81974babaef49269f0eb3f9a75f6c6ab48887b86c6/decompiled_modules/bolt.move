module 0x9a6d0b71dcbf6ee5bbd43f81974babaef49269f0eb3f9a75f6c6ab48887b86c6::bolt {
    struct BOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLT>(arg0, 9, b"BOLT", b"Bolt Token", b"A new token on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOLT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

