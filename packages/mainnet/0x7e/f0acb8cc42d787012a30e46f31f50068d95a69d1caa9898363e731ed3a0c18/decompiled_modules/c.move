module 0x7ef0acb8cc42d787012a30e46f31f50068d95a69d1caa9898363e731ed3a0c18::c {
    struct C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C>(arg0, 6, b"C", b"C", b"cat sleep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicb73yc7w7mzfkwbvszkwd7x2ublqm3q6muzgwycs5uflimldmhay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<C>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C>>(v2, @0xdb7989b98d681455f424035e3f01c02e27f738fdd6634ef34dedf576a9d8cea);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<C>>(v1);
    }

    // decompiled from Move bytecode v6
}

