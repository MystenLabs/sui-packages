module 0x2c67696490823e2e6687fb3db83dffc166b4754757f43586394e7f58d1666398::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 6, b"Blast", b"Blastoise", b"SUI moves like water. Blast is water. It's a perfect overlap: velocity, flexibility, power under pressure. $BLAST is a signal. A shell-shocked, shade-wearing surge toward a new frontier.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwa7bg74q3kj5l2c564x2uqv3esqxhkbbtz6jb2weufywy5qtjxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

