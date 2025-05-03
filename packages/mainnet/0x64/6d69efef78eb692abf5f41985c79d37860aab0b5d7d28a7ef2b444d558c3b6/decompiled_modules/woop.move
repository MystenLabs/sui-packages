module 0x646d69efef78eb692abf5f41985c79d37860aab0b5d7d28a7ef2b444d558c3b6::woop {
    struct WOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOP>(arg0, 6, b"WOOP", b"WOOP SUI", b"\"WE ARE WOOP WOOP\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclepcw2642lwqnozytu7qjbrazuwizrcv3xinzhwqfeq3kx32xxa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

