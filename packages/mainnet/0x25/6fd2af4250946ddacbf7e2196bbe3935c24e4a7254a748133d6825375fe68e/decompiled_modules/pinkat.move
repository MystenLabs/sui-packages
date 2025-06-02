module 0x256fd2af4250946ddacbf7e2196bbe3935c24e4a7254a748133d6825375fe68e::pinkat {
    struct PINKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKAT>(arg0, 6, b"PINKAT", b"Sui Pinkat", b"koolest pinkat on da block", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkuw25hfrvbcu6vvqco2uexj56fcliibeqg7i4mx3rztdhp2sjwq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PINKAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

