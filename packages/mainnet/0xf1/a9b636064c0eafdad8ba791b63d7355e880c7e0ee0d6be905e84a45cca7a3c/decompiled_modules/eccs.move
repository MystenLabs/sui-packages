module 0xf1a9b636064c0eafdad8ba791b63d7355e880c7e0ee0d6be905e84a45cca7a3c::eccs {
    struct ECCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECCS>(arg0, 9, b"ECCS", b"East Coast Cow Sharks", b"ECCS is a token for the East Coast Cow Sharks server for the game Deadside", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ECCS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECCS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

