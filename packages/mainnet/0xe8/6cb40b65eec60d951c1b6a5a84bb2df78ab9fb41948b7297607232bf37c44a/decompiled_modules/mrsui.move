module 0xe86cb40b65eec60d951c1b6a5a84bb2df78ab9fb41948b7297607232bf37c44a::mrsui {
    struct MRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSUI>(arg0, 6, b"MRSUI", b"Mr Sui", b"The only ticker that makes sense on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihq5jgs72gj4v5555iujuu6fswrojzydmgtbw7sdnxvwk5r3uhune")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MRSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

