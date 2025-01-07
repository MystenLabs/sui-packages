module 0xec5cc355de9c01a6d3833d564d102d733d52d932bf3d12286f10ddb116c423ec::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 6, b"ELMO", b"Sui Elmo", b"Elmo is the legendary character from the classic TV Show Elmo's World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_16_18_46_df2890e8ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

