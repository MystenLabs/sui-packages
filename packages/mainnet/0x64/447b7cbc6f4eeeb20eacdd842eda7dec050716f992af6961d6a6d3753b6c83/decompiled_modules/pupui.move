module 0x64447b7cbc6f4eeeb20eacdd842eda7dec050716f992af6961d6a6d3753b6c83::pupui {
    struct PUPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUI>(arg0, 6, b"PUPUI", b"PUPUI 2.0", b"$PUPUI is back, all is up to you to buy or no, we will bringing back meme season on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignautjryzza4wxeylygackidg7n3ocp6yww33h2rgwuiq53gjogq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

