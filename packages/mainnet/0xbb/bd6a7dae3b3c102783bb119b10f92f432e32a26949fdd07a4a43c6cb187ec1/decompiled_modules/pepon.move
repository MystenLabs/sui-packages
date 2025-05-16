module 0xbbbd6a7dae3b3c102783bb119b10f92f432e32a26949fdd07a4a43c6cb187ec1::pepon {
    struct PEPON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPON>(arg0, 6, b"PEPON", b"PEPEMON", b"PEPEMON Born in the toxic swamps of 4chan and raised on a diet of NFT and crypto cope the Vintage Pepemon meme is a grotesque fusion of Pepe the Frogs corpse and the rotting nostalgia of 90s Pokemon bootlegs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcsd6s757lkr4is66wjyz5jujmlt5hzhfo2776bngjzx2yszfvxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

