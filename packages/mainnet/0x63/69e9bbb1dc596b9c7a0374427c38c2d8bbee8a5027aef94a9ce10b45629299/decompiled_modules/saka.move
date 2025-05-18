module 0x6369e9bbb1dc596b9c7a0374427c38c2d8bbee8a5027aef94a9ce10b45629299::saka {
    struct SAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAKA>(arg0, 6, b"SAKA", b"akamaru", b"NARU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebfwwlqmfvxdtqmqygrluq3d3x5sp6dypwtqbue2cx22fbe6mvfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

