module 0x53206f05910b20596bff721e9b6affc22fdf09c768b9e6fb82f3b9b9cc01a205::slayer {
    struct SLAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAYER>(arg0, 6, b"SLAYER", b"Slayer On Sui", x"536c6179657220697320612063756c742d64726976656e20616e696d65206d656d6520666f72636520626f726e206f6e205375692e0a4d61736b65642c2073696c656e742c20616e642072656c656e746c657373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib2dabu2juo6sfg3n6new45z33oqvw7onjzogkdvebhv2rgqxvyum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAYER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLAYER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

