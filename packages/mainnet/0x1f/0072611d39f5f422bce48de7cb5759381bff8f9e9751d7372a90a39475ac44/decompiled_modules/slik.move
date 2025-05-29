module 0x1f0072611d39f5f422bce48de7cb5759381bff8f9e9751d7372a90a39475ac44::slik {
    struct SLIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIK, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 777 || 0x2::tx_context::epoch(arg1) == 778, 1);
        let (v0, v1) = 0x2::coin::create_currency<SLIK>(arg0, 6, b"SLIK", b"SLIK", b"Sophisticated degeneracy only on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmSozFA1aHmmMcyMZDgw2esrXe5tkPYaCZuFuDHDfUy3XC"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLIK>(&mut v2, 1000000000000000, @0xaefae8c81d81b7440035ab6f661f79fd9effefff15cb25fe322242b312a84742, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIK>>(v2, @0xaefae8c81d81b7440035ab6f661f79fd9effefff15cb25fe322242b312a84742);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

