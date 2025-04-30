module 0x5aec0a30bf115d804b1eca3da602b542ad812870eb89041f920943a6b8b68c17::crypto {
    struct CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO>(arg0, 9, b"CRYPTO", b"CRYPTO SUCKS", b"Test run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ecdf159f37387a5bca4c5c8db632a76dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

