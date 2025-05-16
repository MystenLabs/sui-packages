module 0x895514b368336e74129313e1401df5a48c50181a751107800c0950f40aebf2cb::walle {
    struct WALLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLE>(arg0, 6, b"WALLE", b"WALLE WHALE", b"Be a $WALLE, not a shrimp!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic225abmhjacvetujr6h35iaqc7nic2n2hzzkagrlnobifievnku4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

