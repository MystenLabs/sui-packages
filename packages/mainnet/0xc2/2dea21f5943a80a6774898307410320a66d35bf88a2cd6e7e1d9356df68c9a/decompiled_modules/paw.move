module 0xc22dea21f5943a80a6774898307410320a66d35bf88a2cd6e7e1d9356df68c9a::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PawPaw", x"546865206d6f73742062616461737320646f6720697320636f6d696e6720746f20245355490a24504157", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6d6fc46jqgmlrbo7ybr23x7zyen6ysmp6o2sta4hlw736oittye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

