module 0x35da3f9bc0021343c864f936e8513c2fbb191762f1b8a228474448861627c79c::suidown {
    struct SUIDOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOWN>(arg0, 6, b"SUIDOWN", b"WE WRESTLE EVERYTHING", b"WWE Memecoin: The ultimate crypto cage match in the WWE arena of blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifiw4qtztza7ggnso6ei4wcealxv6ryhgbu3ezoewxo3bqzcgc3sa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOWN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

