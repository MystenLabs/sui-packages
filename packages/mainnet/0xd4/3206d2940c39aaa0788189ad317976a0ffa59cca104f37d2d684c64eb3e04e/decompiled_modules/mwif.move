module 0xd43206d2940c39aaa0788189ad317976a0ffa59cca104f37d2d684c64eb3e04e::mwif {
    struct MWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWIF>(arg0, 6, b"MWIF", b"Moo Deng Wif Hat", b"A fan based meme coin for the world's most famous baby hippo, Moo Deng, but wif a hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005919_5e43a5bc52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

