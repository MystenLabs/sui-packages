module 0xd9db96aa62ceace1b5143c766846369f7f1277c3224dac7fc9872be4b3147b16::zowie {
    struct ZOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOWIE>(arg0, 6, b"ZOWIE", b"ZOWIE of SUI", b"ZOWIE is BORN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigm7cgku4fphp36qzhphzdklbgzloov5hy2jhgopwqb5jntc6wvz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOWIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

