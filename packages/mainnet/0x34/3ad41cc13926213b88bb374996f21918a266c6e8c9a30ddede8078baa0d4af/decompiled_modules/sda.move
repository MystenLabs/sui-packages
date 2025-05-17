module 0x343ad41cc13926213b88bb374996f21918a266c6e8c9a30ddede8078baa0d4af::sda {
    struct SDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDA>(arg0, 6, b"Sda", b"caca", b"vavasva", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkjdy3fddrwappdoonihlmv4tsqeyhzabrimwdaihtrmnli3mi2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

