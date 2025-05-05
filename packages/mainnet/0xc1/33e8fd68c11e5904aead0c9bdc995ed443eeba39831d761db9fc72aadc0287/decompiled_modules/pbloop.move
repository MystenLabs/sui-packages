module 0xc133e8fd68c11e5904aead0c9bdc995ed443eeba39831d761db9fc72aadc0287::pbloop {
    struct PBLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBLOOP>(arg0, 6, b"PBLOOP", b"PIKA BLOOP", b"pika is bloop step mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihvnfisx3zpfs2blt5d4vphjthwjps4qmfkk46pwml3tgxoh4uyse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PBLOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

