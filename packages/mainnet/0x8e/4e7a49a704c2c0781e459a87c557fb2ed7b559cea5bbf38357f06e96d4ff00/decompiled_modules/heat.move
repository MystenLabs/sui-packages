module 0x8e4e7a49a704c2c0781e459a87c557fb2ed7b559cea5bbf38357f06e96d4ff00::heat {
    struct HEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAT>(arg0, 9, b"DEGREES", b"HEAT", b"Let's heat up SUI blockchain, shall we? No road map, just vibing. Upgrade_Cap - immutuble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeifa4tm4fn4rnegi4rtpy2qr6wzd7ateqbsh3iov2ckvytp3kbrhdu.ipfs.nftstorage.link/07ruzeup50xp.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAT>>(v1);
        0x2::coin::mint_and_transfer<HEAT>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

