module 0xb21736a8fd331173247b0fb89d5ced82b932e5e377317a69a358cc7d7c744b5c::cabal {
    struct CABAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABAL>(arg0, 9, b"cabal", b"sabula", b"stake your cabals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CABAL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABAL>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CABAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

