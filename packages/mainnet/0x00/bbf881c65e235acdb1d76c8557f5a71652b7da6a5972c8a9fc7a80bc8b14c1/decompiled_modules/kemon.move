module 0xbbf881c65e235acdb1d76c8557f5a71652b7da6a5972c8a9fc7a80bc8b14c1::kemon {
    struct KEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMON>(arg0, 6, b"KEMON", b"Blue Pokemon Sui", b"The first Blue pokemon on sui network!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreife4uwct36rlmbfudavlm334v3ua63qglurmip4rov5mqdckxqbs4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

