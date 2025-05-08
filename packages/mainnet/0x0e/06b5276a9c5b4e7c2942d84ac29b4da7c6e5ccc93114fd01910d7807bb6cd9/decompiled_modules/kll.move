module 0xe06b5276a9c5b4e7c2942d84ac29b4da7c6e5ccc93114fd01910d7807bb6cd9::kll {
    struct KLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLL>(arg0, 6, b"Kll", b"24", b"3424", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibgnc6w33qdnrfh4qm4jj23luc6idbzdocpyywvnh3c4ixursmgsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

