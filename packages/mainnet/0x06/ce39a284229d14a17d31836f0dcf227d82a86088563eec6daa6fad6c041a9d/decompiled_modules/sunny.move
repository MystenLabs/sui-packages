module 0x6ce39a284229d14a17d31836f0dcf227d82a86088563eec6daa6fad6c041a9d::sunny {
    struct SUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNNY>(arg0, 6, b"SUNNY", b"Sunny of SUI", b"Sunny of Sui is the cheerful spirit of the Sui blockchain, bringing fun, community, and decentralized energy to the world of crypto. Born from the sunniest corner of the memevers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreign46cbfk77oll7yghr3x545vy4sw5iiicrv2cae7wyjgfjokhq4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUNNY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

