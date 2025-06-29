module 0x8963a9a2fb1c777476822e715446fcb20be34e7d19a41fb8d23dc705ce4a27c1::whel {
    struct WHEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHEL>(arg0, 6, b"Whel", b"Cute Whel", b"Just a cute whel in da big sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7ty2xad5o2nlggyishj2pbnsjne3bjolrighny3nlxafnyzts6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WHEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

