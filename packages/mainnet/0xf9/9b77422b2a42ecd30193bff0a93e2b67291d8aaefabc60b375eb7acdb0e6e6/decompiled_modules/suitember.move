module 0xf99b77422b2a42ecd30193bff0a93e2b67291d8aaefabc60b375eb7acdb0e6e6::suitember {
    struct SUITEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEMBER>(arg0, 6, b"SUITEMBER", b"Suitember On Sui", b"Sui September", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibu7whmzqvhfzm2encirnrlm5g5sgfcsrj3c53tdz3abbkcbpsyke")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITEMBER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

