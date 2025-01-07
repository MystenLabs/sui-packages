module 0x37ab72c470b40fd75e8b8807a3cb3e0823994c56692520fb2a40f6468ee22463::SongoftheEnclave {
    struct SONGOFTHEENCLAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONGOFTHEENCLAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONGOFTHEENCLAVE>(arg0, 0, b"COS", b"Song of the Enclave", b"The hem of worlds unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Song_of_the_Enclave.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONGOFTHEENCLAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONGOFTHEENCLAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

