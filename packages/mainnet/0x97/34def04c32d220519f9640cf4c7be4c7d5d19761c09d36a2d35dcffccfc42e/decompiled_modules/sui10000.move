module 0x9734def04c32d220519f9640cf4c7be4c7d5d19761c09d36a2d35dcffccfc42e::sui10000 {
    struct SUI10000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI10000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI10000>(arg0, 6, b"SUI10000", b"PUMP 10000% SUI", b"10000% SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicx2cehjjjcj66p7ejzvgekikewyxlg5bkj5g5md4u4qeq4m4cibu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI10000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI10000>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

