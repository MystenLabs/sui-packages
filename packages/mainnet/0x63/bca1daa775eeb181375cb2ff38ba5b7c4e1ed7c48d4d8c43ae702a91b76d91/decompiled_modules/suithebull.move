module 0x63bca1daa775eeb181375cb2ff38ba5b7c4e1ed7c48d4d8c43ae702a91b76d91::suithebull {
    struct SUITHEBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITHEBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITHEBULL>(arg0, 6, b"SUITHEBULL", b"Sui  The  Bull", b"Sui The  Bull Sui The  Bull Sui The  Bull Sui The  Bull Sui The  Bull Sui The  Bull Sui The  Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_the_bull_591af3a9ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITHEBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITHEBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

