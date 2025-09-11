module 0x2fbc150767c5edcfecce245fe23010fda40e1595aba2cadc97db918b921356d5::sporus {
    struct SPORUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPORUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPORUS>(arg0, 6, b"SPORUS", b"Sporopus", b"The Meme leaves the Lab. Embryo token SPORUS arrives. Zero Level opens on the SUI blockchain on September 11, 2025. A Game-epidemic that spreads by public selection and transparent flows.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieoixoaga3vk6fspo36m3udmq3cvay3sucq4ihs64oobdocnouxba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPORUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPORUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

