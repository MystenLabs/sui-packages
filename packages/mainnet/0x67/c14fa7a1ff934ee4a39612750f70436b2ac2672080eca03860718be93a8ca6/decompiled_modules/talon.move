module 0x67c14fa7a1ff934ee4a39612750f70436b2ac2672080eca03860718be93a8ca6::talon {
    struct TALON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALON>(arg0, 6, b"TALON", b"Talon On Sui", b"$TALON, we build an \"invisible steel shield\" to protect you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaun7i7uyank3g4x4wp7ystjpefiraohwual5eng3muhowv2kl7re")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TALON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

