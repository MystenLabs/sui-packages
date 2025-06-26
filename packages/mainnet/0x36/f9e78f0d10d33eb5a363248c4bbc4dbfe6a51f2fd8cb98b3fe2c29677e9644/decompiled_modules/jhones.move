module 0x36f9e78f0d10d33eb5a363248c4bbc4dbfe6a51f2fd8cb98b3fe2c29677e9644::jhones {
    struct JHONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHONES>(arg0, 6, b"Jhones", b"Juan is A Niiger", b"yea jon jones", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhbrhgvpanq6udkfio47l2mb2jvyb63zqfohabvm5wjxa5nkyzhi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JHONES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

