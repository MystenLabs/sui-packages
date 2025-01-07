module 0x54fb0402f92e0edf2f617ef754486b6b8496af489ba67853916dfb2ed1cedaaa::dug {
    struct DUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUG>(arg0, 9, b"DUG", b"Sui Dug", b"Let's get it up $DUG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmSnKB9YinWkfPcyL2Tkf3E28jb7JECg4xN565sYvqv5oc?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

