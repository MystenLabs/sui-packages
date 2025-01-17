module 0x32552b4c9ce2aee570e8b6ffc4851d3f024d2041814337521e2a41bb71d56c55::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"CAESUIUS GOD BULLYS", b"Unpredictable, Chaotic Behavior: Witness the majesty of Caesuius, the digital bull, as he randomly terrorizes the Sui blockchain. Will he mysteriously delete your wallet? Freeze your transactions? Perhaps even crash the entire network? You never know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737094403769.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

