module 0xc16ca56d76353cb11f2ee214b092f8d138691f1a4a103fb325c3323250d07025::ourw {
    struct OURW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OURW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OURW>(arg0, 6, b"OURW", b"Our West Lancs", b"Local Independents putting residents first & foremost. Promoted by Charles Berry on behalf of OWL candidates all of 18 Halsall Lane, Ormskirk, L39 3AU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieeq3pmni7dfmv2wpv3mszgjyv2wjnbvniim3jhqlfmac76sipuyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OURW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OURW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

