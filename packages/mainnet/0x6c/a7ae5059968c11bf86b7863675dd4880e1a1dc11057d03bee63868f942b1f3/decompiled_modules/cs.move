module 0x6ca7ae5059968c11bf86b7863675dd4880e1a1dc11057d03bee63868f942b1f3::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CS>(arg0, 6, b"CS", b"CS", b"cat sleep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicb73yc7w7mzfkwbvszkwd7x2ublqm3q6muzgwycs5uflimldmhay")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v2, @0xdb7989b98d681455f424035e3f01c02e27f738fdd6634ef34dedf576a9d8cea);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v1);
    }

    // decompiled from Move bytecode v6
}

