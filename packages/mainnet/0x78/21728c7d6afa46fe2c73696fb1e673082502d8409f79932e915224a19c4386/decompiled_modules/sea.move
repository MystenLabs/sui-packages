module 0x7821728c7d6afa46fe2c73696fb1e673082502d8409f79932e915224a19c4386::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 9, b"SEA", b"Sui Earn Alliance", b"earn by playing web2 and web3 games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.earnalliance.com/RT6438")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

