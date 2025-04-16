module 0x8d93f7845e6ae1e9202e1d56c5d9b2079f6d3b93519794ea356d23aaa6103017::orla {
    struct ORLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORLA>(arg0, 6, b"ORLA", b"Charlotte And Orla", b"The famous dog named Orla with Princess Charlotte", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifpxrdc4udmst4uu7pwjspfncdzxwck37bjzj4dj3l4ptrdvhk63e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

