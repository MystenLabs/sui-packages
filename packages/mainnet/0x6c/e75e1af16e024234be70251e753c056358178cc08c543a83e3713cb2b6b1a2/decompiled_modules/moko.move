module 0x6ce75e1af16e024234be70251e753c056358178cc08c543a83e3713cb2b6b1a2::moko {
    struct MOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKO>(arg0, 6, b"MOKO", b"SUIMOKONA", b"Get Ready for $MOKONA: Revolutionize Your Sui Experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhsnevopai4xd6sp3bgp7svcdcm2h7bvuuci5jbepahjp6yc6axe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

