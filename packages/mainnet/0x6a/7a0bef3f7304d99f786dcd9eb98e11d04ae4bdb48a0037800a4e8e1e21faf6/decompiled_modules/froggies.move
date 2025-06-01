module 0x6a7a0bef3f7304d99f786dcd9eb98e11d04ae4bdb48a0037800a4e8e1e21faf6::froggies {
    struct FROGGIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGIES>(arg0, 6, b"FROGGIES", b"FROG ON SUI", b"The No 1 Frog Meme on Sui Network. Fighting Ruggers and Jeeters to make sure you don't go Rekt. Don't go Rekt get Froggies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejeit3ozdskvyjjnjftamgo7zhnc5kqthx7dhr4mw7nmzuf2tx4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGIES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

