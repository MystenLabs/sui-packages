module 0x77cb23a24e71295fc84e8b84ab6c4292f59939b63960a39eac70f3cdb74229bd::laggy {
    struct LAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAGGY>(arg0, 6, b"LAGGY", b"LAGGY THREE-LEGGED DOG", b"Laggy is the three-legged dog that loves to splash waters with its paws.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihr72gdiq6m7hheugul3ucuxhzje6khwvaxksgbfyvasikf6c6jrq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

