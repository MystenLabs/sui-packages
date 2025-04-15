module 0x395aacaee8b21e821f3af6817102bc936208abad222ad7689cd1d9127a05a7f1::moonbags {
    struct MOONBAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBAGS>(arg0, 6, b"MOONBAGS", b"moonbags.io", b"Ticker!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicxtah2c73plijwab3vpju6m3ur3a4ke3i7cq6jwiewsl4d5txo2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBAGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONBAGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

