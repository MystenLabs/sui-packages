module 0x8e7113dec10519f6e2404dc56510d33879c7fe2e2639317eb91e8a49f768e720::pot {
    struct POT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POT>(arg0, 6, b"Pot", b"Marijuana", b"Marijuana to all the pot heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiffu6nz756sd7tytkiybgtsdvlmuq6po3njjjkykeno2yzqfp425e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

