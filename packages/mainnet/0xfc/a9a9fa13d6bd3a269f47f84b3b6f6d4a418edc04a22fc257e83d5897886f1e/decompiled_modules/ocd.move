module 0xfca9a9fa13d6bd3a269f47f84b3b6f6d4a418edc04a22fc257e83d5897886f1e::ocd {
    struct OCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCD>(arg0, 9, b"OCD", b"onchain dog", b"the dog is onchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXnotVBHECZgJ9SAnKEzVyHiGRaRVhQ9zh3TqoyKrWe1Z")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OCD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

