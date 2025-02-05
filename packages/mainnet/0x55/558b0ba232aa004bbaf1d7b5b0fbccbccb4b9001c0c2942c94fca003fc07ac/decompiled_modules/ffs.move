module 0x55558b0ba232aa004bbaf1d7b5b0fbccbccb4b9001c0c2942c94fca003fc07ac::ffs {
    struct FFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFS>(arg0, 6, b"FFS", b"FuzzyFury  On Sui", b"\"Welcome to FuzzyFury! We're listening to you.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_03_22_21_25_8fe4fb0a17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

