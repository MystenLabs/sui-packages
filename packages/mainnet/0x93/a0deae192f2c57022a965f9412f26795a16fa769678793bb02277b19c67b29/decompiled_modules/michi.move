module 0x93a0deae192f2c57022a965f9412f26795a16fa769678793bb02277b19c67b29::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"MICHI", b"MICHI SUI", b"$Michi Sui the infinity Meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigtz63dt5vsnl2auo4nvffvm5wkngnvycgak4egnqceynohs7nwaq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MICHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

