module 0xd750a49f700f909f69112e9a7659b5e621564ac5aa36b881e65e34b43dd51692::asdf {
    struct ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDF>(arg0, 6, b"ASDF", b"asdas", b"ASdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidlt3jg3te5pih62qcvunjy7sg6rje3wfh2666skl26gkwsb2n3ca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

