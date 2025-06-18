module 0x41a4d016f26b581d122bdcc8a592a59e6c10d26cfdabfb73675fd336ac749b17::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Catoshi", b"Meet Catoshi  the most daring cat on the Sui network Straight from the Sui network Catoshi is more than a meme he is a symbol of charisma wit and decentralization with style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigt6dwpalrs2s3xxyy7kr7sme6abgud3miwsqxlweijin3lpvx5pq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

