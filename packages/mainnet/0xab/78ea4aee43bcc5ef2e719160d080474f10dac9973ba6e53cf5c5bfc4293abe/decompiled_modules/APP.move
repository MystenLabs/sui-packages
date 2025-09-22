module 0xab78ea4aee43bcc5ef2e719160d080474f10dac9973ba6e53cf5c5bfc4293abe::APP {
    struct APP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APP>(arg0, 9, b"apple", b"APP", b"apple", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758541502/sui_tokens/oe2jplpvg5t2ddlejydf.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<APP>>(0x2::coin::mint<APP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

