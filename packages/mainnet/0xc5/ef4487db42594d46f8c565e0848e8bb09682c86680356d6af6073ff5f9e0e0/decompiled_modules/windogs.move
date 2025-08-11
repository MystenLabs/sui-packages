module 0xc5ef4487db42594d46f8c565e0848e8bb09682c86680356d6af6073ff5f9e0e0::windogs {
    struct WINDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINDOGS>(arg0, 9, b"windogs", b"windogs", b"Twitter: https://twitter.com/i/communities/1954867422563070346 | Website: https://windogs.xyz/ | Created on: https://pump.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibv7jjpjyqqerl5rj2tpgtn36ekuvufuo2yjulgo7fnav6v2zn7jq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WINDOGS>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINDOGS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

