module 0x6ad2155c45a99fbfc6222150c5f65a73ca92d10de39c02c78745570f508c5e7c::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DOG FACE", b"SuiEmoji Dog Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/dog.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

