module 0xd095cf235d8faa1ac9be48174c04e23b6951fb36d102fffbcd15e4340e0ca804::drill {
    struct DRILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRILL>(arg0, 6, b"DRILL", b"ONE Drill", b"Throwaway test coin for a bridge rehearsal. No value.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DRILL>>(0x2::coin::mint<DRILL>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

