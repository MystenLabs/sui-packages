module 0xf7a8fee9e23c498d31888795192239a3ee3007b0ce0ee82ec70cd6801f1c6430::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 6, b"Nar", b"Not Another Rug", b"Bye buddy I hope you find your dad. This is not another rug its just a Narwhal from buddy the elf. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lol_505e9f97f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

