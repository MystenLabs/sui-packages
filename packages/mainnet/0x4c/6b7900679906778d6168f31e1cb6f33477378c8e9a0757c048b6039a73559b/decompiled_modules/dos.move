module 0x4c6b7900679906778d6168f31e1cb6f33477378c8e9a0757c048b6039a73559b::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"DOGE ON SUI", b"doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibxp5nxyvnz3arrhtdvfx7vdqeajgcrhkwsscuuxktuthqxhrcvza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

