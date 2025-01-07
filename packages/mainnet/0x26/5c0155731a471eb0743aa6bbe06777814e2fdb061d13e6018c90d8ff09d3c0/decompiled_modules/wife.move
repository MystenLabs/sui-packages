module 0x265c0155731a471eb0743aa6bbe06777814e2fdb061d13e6018c90d8ff09d3c0::wife {
    struct WIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFE>(arg0, 6, b"WIFE", b"Wife On Sui", b"No TG, No X, No Website, only have wife", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000255819_844e48a1e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

