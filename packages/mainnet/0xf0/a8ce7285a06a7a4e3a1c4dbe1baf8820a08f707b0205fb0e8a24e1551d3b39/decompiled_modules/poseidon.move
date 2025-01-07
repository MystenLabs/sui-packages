module 0xf0a8ce7285a06a7a4e3a1c4dbe1baf8820a08f707b0205fb0e8a24e1551d3b39::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 5, b"POSEIDON", b"Poseidon Finance", b"Poseidon Finance is an aggressive performance-oriented fund that will invest in DeFi tokens, venture equity, pre-seed of early-stage tokens, and liquidity pools while developing the products", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JcmWYzv.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POSEIDON>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

