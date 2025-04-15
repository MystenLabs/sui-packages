module 0xcd8ff46aceb5c6ad2ad2d768f24dfd5ec83e9f88006a233134526b9347017e32::pichai {
    struct PICHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICHAI>(arg0, 6, b"Pichai", b"Sundar Pichai", b"CEO,  Google and Alphabet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreie6fq76xszwkbtkg4eh4rulcm3do3vljrfjz5avhssrqp3ld3a5li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PICHAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

