module 0x926a2c0c1a393034a7ebb3c8e8ec76ef12b80ee0872ee9053e60a29647ca7c1e::gents {
    struct GENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENTS>(arg0, 6, b"Gents", b"The Gents", b"Welcome $Gents this  is a community of sophisticatedly smart chain goers that will be launching NFTs that profit share revenue from Gentora LLC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihmnp6o7xumb6s2hfmbbxmx4op2i7q4gacby6injmjsy7dumlyyl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

