module 0xae37dbe982f7adf0075bdd4e5e67e14a36a73d76c9a735ad7be07caf1930ae7d::top_g {
    struct TOP_G has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOP_G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOP_G>(arg0, 6, b"Top G", b"Top G Coin", x"546f704720436f696e202824546f7047290a496e73706972656420627920746865206d696e64736574206f6620416e6472657720546174652c2e20486f6c64206c696b65206120546f7020470a234573636170655468654d6174726978207c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiazjghduybbg2im4yy5xv2qx5a7v7c7d3i7nvtnjrtsn3g2wlbtum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOP_G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOP_G>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

