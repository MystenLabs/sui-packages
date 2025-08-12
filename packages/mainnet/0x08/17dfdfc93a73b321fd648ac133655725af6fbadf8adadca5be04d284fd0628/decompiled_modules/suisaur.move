module 0x817dfdfc93a73b321fd648ac133655725af6fbadf8adadca5be04d284fd0628::suisaur {
    struct SUISAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAUR>(arg0, 9, b"SUISR", b"Suisaur", b"A chunky, leaf-backed beast snoozing on a mountain of Sui tokens, with vines that spell SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreiehgcuwfg6tnpd26fkzwvepi7zghjn3slrl72ues5hgknpptjokry")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISAUR>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

