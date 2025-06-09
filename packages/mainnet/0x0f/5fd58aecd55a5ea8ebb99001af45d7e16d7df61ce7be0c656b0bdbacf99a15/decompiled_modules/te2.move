module 0xf5fd58aecd55a5ea8ebb99001af45d7e16d7df61ce7be0c656b0bdbacf99a15::te2 {
    struct TE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TE2>(arg0, 6, b"TE2", b"Test 2", b"fafafa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibpug5nqgc7iwrm3ewhzfxayz3s57pglyha655atadmpvbaozwbby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TE2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

