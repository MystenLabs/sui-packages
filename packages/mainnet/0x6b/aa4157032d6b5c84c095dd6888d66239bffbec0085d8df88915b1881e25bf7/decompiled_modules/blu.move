module 0x6baa4157032d6b5c84c095dd6888d66239bffbec0085d8df88915b1881e25bf7::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"BLU SUI", x"24424c55206c6f6f6b73206c696b6520612063617420616e642062756720616c736f2068617320736978206665657420616e64206c6f766573206d656174210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_Ziu_Beg_F_400x400_1ba0697396.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

