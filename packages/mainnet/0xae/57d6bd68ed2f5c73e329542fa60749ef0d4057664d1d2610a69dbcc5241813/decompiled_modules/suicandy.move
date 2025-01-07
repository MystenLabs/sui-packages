module 0xae57d6bd68ed2f5c73e329542fa60749ef0d4057664d1d2610a69dbcc5241813::suicandy {
    struct SUICANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICANDY>(arg0, 6, b"SUICANDY", b"Sui Candy", b"Sweeten your degeneracy with $SUICANDY! This delightful token brings a burst of flavor to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_76_04b2352d49.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

