module 0xf72a3d312d9ee038be84a90e79f3652f40206766b70ca894b0dd443d291221ee::bags {
    struct BAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGS>(arg0, 6, b"BAGS", b"Backpaaak", b"All in one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifycc3mp5ox5e5qnqd52ns2aalqafzaq5jjkczwtijhkqotkkmhca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAGS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

