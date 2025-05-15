module 0xe8c67f2281f3fb733f51e94911a957dd5028bba7464f4070cb4ada169afd5ea9::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"Team Rocket", b"Team $ROCKET Forged on the $SUI Network. Meme magic meets real-world matter. Print the legend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigz3phhiboxgl4p2e4t77egy4vvjbgrdrermnwysblh4hhsvozbam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

