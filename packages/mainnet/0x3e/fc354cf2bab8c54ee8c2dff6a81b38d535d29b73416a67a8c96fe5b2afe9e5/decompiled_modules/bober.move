module 0x3efc354cf2bab8c54ee8c2dff6a81b38d535d29b73416a67a8c96fe5b2afe9e5::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 9, b"bober", b"boberAI", b"yes bober AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVzpfnwXMLvwcxwgEYV3dgXDF9RzsTPrpR4wANRwqKUzp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

