module 0xe295b0872ece42840914ebca44b8963fb82716a2ea1448bbda289fa7853a08dc::bluedoge {
    struct BLUEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOGE>(arg0, 6, b"BLUEDOGE", b"Bludoge The Bulldog", x"544845205354524f4e4745535420444f47204f4e205355490a5055534820594f5552204c494d4954205749544820424c55444f47452121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuzeg57rl53yuxzwkaclvgpkl5ecqufuhiqkwt2ht2z4z6dpaiee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

