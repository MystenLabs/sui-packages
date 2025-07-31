module 0x57336ca3f2c62536edf99e7348e154b961882b0fb691d4b8861b9c38d9248c67::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DRAGOSUI", b"DONT BUY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsperl25xbefa4gq2uteiqzbuc4p6xvikugehxwbdltdsg4l66gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

