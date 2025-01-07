module 0xdd7a146bfc082ab329a6cc5d9d43d316dd9607c55254b8c7ee65451292ba41c6::poseidon {
    struct POSEIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSEIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POSEIDON>(arg0, 9, b"POSEIDON", b"God of the Sea", b"god of the sea and of water generally, earthquakes, and horses. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JY5uuat.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POSEIDON>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSEIDON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSEIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

