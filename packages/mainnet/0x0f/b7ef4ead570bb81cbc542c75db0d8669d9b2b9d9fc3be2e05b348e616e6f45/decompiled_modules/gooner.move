module 0xfb7ef4ead570bb81cbc542c75db0d8669d9b2b9d9fc3be2e05b348e616e6f45::gooner {
    struct GOONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOONER>(arg0, 6, b"GOONER", b"PURGY PENGOON", b"Token was sitting at under 10k mc and fully dead, it represents a viral tik tok page though that people very much enjoy. 25M likes on tik tok and over 500k followers The previous team didn't really take it seriously and that's why the community wanted to CTO it and give the meme a chance to run and build a real community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaex3uh7jbil7bjsjwgzijypldkuelsiaywom3gbin3lsaovmjvgu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOONER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOONER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

