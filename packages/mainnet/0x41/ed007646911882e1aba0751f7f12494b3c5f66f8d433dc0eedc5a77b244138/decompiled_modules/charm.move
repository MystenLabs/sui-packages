module 0x41ed007646911882e1aba0751f7f12494b3c5f66f8d433dc0eedc5a77b244138::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"CHARM", b"CHARMANDER", b"CHARM POKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic243r2p5ibhdrjfid6d7jwi6n62dlsyijfqwavlrllnunjx3pe2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

