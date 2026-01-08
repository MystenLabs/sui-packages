module 0x1f06cbacd7f2eed9c4aece30bb85fc51a171effe24cfc1639f2fe74a52e4006b::short {
    struct SHORT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHORT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHORT>>(0x2::coin::mint<SHORT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORT>(arg0, 9, b"SHORT", b"SHORT", b"SHORT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-late-hoverfly-823.mypinata.cloud/ipfs/bafybeif5l6alprtw7hzwptwm4q35fzwdismydwwdjfb4ytqkpxa3ij6bp4"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHORT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_v2(arg0: &mut 0x2::coin::TreasuryCap<SHORT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

