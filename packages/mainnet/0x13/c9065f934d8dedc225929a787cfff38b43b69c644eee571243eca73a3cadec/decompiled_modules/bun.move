module 0x13c9065f934d8dedc225929a787cfff38b43b69c644eee571243eca73a3cadec::bun {
    struct BUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUN>(arg0, 9, b"BUN", b"BUNSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZtWGwJhxWVsvm9dqHzCn7mHfdNQ4kNSCMNBaofL9kpwG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

