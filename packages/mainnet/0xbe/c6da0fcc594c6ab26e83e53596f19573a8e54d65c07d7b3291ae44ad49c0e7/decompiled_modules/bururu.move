module 0xbec6da0fcc594c6ab26e83e53596f19573a8e54d65c07d7b3291ae44ad49c0e7::bururu {
    struct BURURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURURU>(arg0, 6, b"BURURU", b"Bururu The Yeti", b"WELCOME TO IGLOO LIVIN WITH BURURU HERE, BURURU THE YETI SHARES HIS COZY, SNOW-FILLED LIFE IN THE FRIENDLIEST WAY POSSIBLE. JOIN IN FOR WARM STORIES, ICE COO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4h4zq3c3xt2qtt5nbwos74akohpv4gvbdzvzstqlfwdwm7rjhza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURURU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURURU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

