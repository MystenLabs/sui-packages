module 0x5fb0c6cfa804b7dd5994ee42ce8c71975fddce31a5eee426c1db128529c9b10::pupui {
    struct PUPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUI>(arg0, 6, b"PUPUI", b"PUPUI 2.0", b"$PUPUI IS BACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignautjryzza4wxeylygackidg7n3ocp6yww33h2rgwuiq53gjogq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

