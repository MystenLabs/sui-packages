module 0xee21038649e7b221518e7c5021909e4061f64149998d687de6a8af79ae64da4b::k11a {
    struct K11A has drop {
        dummy_field: bool,
    }

    fun init(arg0: K11A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K11A>(arg0, 6, b"K11A", b"KUMAR", b"Meme in honor of the man who was the only survivor of the AIR INDIA plane crash in 2025. Meme that will be like seat 11A - Meme that will win life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidkzpxngdcxws5th6tmi7fedpiuhsfv6kpojvluvxju4w27hpbnxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K11A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<K11A>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

