module 0x413f1444b84cbd5067cd36e49990c189ea745793c8c5b376c68f4685f16faac::lulu {
    struct LULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULU>(arg0, 6, b"LULU", b"Lulu The Pomeranian", x"4a75737420612063757465206c696c204c756c75206f6620506f6d6572616e69616e206272696e67696e6720637574656e65737320746f205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_S_Zyyn9_X_400x400_5a73eae5fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LULU>>(v1);
    }

    // decompiled from Move bytecode v6
}

