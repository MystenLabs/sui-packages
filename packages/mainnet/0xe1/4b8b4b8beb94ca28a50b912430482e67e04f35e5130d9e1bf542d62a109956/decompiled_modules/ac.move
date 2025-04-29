module 0xe14b8b4b8beb94ca28a50b912430482e67e04f35e5130d9e1bf542d62a109956::ac {
    struct AC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC>(arg0, 9, b"AC", x"417175614368616e20f09f92a7", b"AquaChan  rules the cryptosea with bubbly charm, fishy logic, and a fork she found in the sand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2c47a1133bb13d485a6825ba7ec468ddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

