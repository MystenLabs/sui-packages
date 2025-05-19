module 0xc94acf30ed01031abd47411de5dedf32111a8683b7f57aa1a6006f082f78c229::rugo {
    struct RUGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGO>(arg0, 6, b"RUGO", b"RUGO THE RUG", b"The trollest mat furie's character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib7ctdw2zmetwgln4qn3rtjpjnktvr4w4atu3njsrb5emzsg5akgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

