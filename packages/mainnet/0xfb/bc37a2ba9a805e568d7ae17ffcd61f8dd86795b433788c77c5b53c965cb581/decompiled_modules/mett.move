module 0xfbbc37a2ba9a805e568d7ae17ffcd61f8dd86795b433788c77c5b53c965cb581::mett {
    struct METT has drop {
        dummy_field: bool,
    }

    fun init(arg0: METT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METT>(arg0, 6, b"METT", b"thenightwemet", b"MET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibh2uf2hdato2scgisz7bhtuxbge5txyer7u3iijn7vwlz5ksi3ci")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<METT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

