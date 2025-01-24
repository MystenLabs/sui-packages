module 0xaad7fa97071782a38b97f901c27afb4c2894b7fb75d28cc443eec7c7cabb9f50::TDT1 {
    struct TDT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDT1>(arg0, 9, b"TDT1", b"TDT1", b"TESTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzqBvzdVf-9AKTWLtxFIOKkqPY_K9pOViKMA&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDT1>>(v1);
        0x2::coin::mint_and_transfer<TDT1>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TDT1>>(v2);
    }

    // decompiled from Move bytecode v6
}

