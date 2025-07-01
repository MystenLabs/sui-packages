module 0x973279a71467a3139276d1d8b2c2cbe9b0f3274470e3c771e7705ddeb2515671::sush {
    struct SUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSH>(arg0, 6, b"SUSH", b"SUNSHINE", b"Creating advanced technology to make mundane tasks effortless, free up your time, and make it easier to be thoughtful.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibacujylgmhnybbhhocfia7qa2irbwczlw5imn52k4h4xiqknoj64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

