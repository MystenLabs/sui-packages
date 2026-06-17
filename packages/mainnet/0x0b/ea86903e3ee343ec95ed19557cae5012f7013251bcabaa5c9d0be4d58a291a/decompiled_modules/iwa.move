module 0xbea86903e3ee343ec95ed19557cae5012f7013251bcabaa5c9d0be4d58a291a::iwa {
    struct IWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWA>(arg0, 6, b"IWA", b"Internet Water Army", b"This is a powerful army on the internet; they are everywhere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiepnvotnvvrkk7itkdnbw2zjv7azbyqyhuubwvqyij7mut4kwa2nu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IWA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

