module 0x42f1ee8d0932cabcb9fd2378e6f121b931f45ae8a83351d2cd28793c45a9e1f::dig {
    struct DIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIG>(arg0, 6, b"DIG", b"Sui Dig", b"Community token on a mission for greatness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidgnvzmkwxc2g5x5zcoddu23cn4oyqkw7slmp7f6hbmgw6r3fftba")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

