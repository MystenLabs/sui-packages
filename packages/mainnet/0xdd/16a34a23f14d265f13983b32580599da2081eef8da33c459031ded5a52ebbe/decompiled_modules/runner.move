module 0xdd16a34a23f14d265f13983b32580599da2081eef8da33c459031ded5a52ebbe::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"SUI RUNNER", b"We are launching the first real online game on the Sui Network. You can play online games with Sui Runner and win Sui Runner. The V1 version of the game is now live, many more will come soon. You can enter Sui Runner award-winning battles with your friends, we are coming soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidm5p5thk4v7xh5map37xkz6yqijwcru52mo727u6xq3t5fqgzm6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUNNER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

