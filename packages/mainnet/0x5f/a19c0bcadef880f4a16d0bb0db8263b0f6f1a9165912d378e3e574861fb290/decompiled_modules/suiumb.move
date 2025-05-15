module 0x5fa19c0bcadef880f4a16d0bb0db8263b0f6f1a9165912d378e3e574861fb290::suiumb {
    struct SUIUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIUMB>(arg0, 6, b"SUIUMB", b"Suiumbreon Pokemon", b"Build the first P2E Pokemon game on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiktoy6saxkt4iadj5gyg45ovgjokrqivvkviiskzqb7m53ninli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIUMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIUMB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

