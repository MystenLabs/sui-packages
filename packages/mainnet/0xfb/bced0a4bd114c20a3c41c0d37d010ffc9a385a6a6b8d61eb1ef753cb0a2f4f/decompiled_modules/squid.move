module 0xfbbced0a4bd114c20a3c41c0d37d010ffc9a385a6a6b8d61eb1ef753cb0a2f4f::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"SQUID SUI", b"Meme coin on Sui Network | Community-driven & fun | Riding the waves of crypto & memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6li5f2vlnia27jqdhjdpvm2enl2euetew5a4mduqmqsvy7xz2jq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQUID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

