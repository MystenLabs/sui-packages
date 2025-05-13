module 0x1f5f66ab6ad08fd3eafb8a905d813affb7ba449c90ce77e5c59a64052cdcf866::jeli {
    struct JELI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELI>(arg0, 6, b"JELI", b"Jelicoin", b"its the jeli coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicv4fridmp3aisvpjsakds2ipptb4w4qsqjgto36ugouo3dfcpvpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JELI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

