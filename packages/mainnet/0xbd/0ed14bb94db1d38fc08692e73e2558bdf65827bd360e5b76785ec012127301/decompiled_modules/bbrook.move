module 0xbd0ed14bb94db1d38fc08692e73e2558bdf65827bd360e5b76785ec012127301::bbrook {
    struct BBROOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBROOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBROOK>(arg0, 6, b"BBROOK", b"Baby Brook", b"Baby Brook ($BBROOK) is a chaotic baby memecoin born to break the rules and ride the hype. No promises just pure meme power and community vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmylci5vde5uvbtxmkojzdt2xqvz2vvs2ttdi3pgbubg4vn7kigi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBROOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBROOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

