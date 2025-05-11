module 0x959a5f2ba5f8bba774c1363feef10598e588fb5311da8f30e2eab19eba13cd9::justameme {
    struct JUSTAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTAMEME>(arg0, 6, b"JustAmeme", b"Just A sui Token", b"Just pure meme madness and community love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7wqy4niurdydnp7yjskyirv5vo4qn5sh7t57na2eikqy5a3e7vm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUSTAMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

