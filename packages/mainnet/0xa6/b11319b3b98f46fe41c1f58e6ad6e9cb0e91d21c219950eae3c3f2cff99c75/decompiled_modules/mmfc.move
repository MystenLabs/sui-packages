module 0xa6b11319b3b98f46fe41c1f58e6ad6e9cb0e91d21c219950eae3c3f2cff99c75::mmfc {
    struct MMFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMFC>(arg0, 6, b"MMFC", b"MARS FREEDOM CITY", b"MARS freedom city", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000841155_3b08486055.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

