module 0x1815f4a2cd454743f54d594cd9d20bb2e7da82f6e5160e0cf8ca4edbf081b9c2::higher {
    struct HIGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGHER>(arg0, 6, b"HIGHER", b"FUCK YOU HIGHER", b"FUUUUUCK YOU HIGHER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqowhqpd4oeyp2c3wdzl7vk7c6h2idvindzxsfhlwmwmwjmq76ku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIGHER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

