module 0x8c62e56a4ddee1c0c823e8bc9b23d7f9e3f52cf554f179c4375bfcb8c58b153::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"test", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2024_10_17_at_15_09_38_902ecd88be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

