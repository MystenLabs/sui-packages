module 0x21cd5d15b1da8bd78356e37bb7a2eeacebe9f6856323abea5424a7a990f9a831::hoer {
    struct HOER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOER>(arg0, 6, b"HOER", b"13243", x"c6af454744", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid75ph2nxiwnffgrxhngu522fzf6ivtzrro5apchirkpwmjb3aqnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

