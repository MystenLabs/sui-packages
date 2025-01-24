module 0xa13e7dff84d4d0dde8c9f367e99d303733de2e76636fd3ed3008e77dd0801365::elonai {
    struct ELONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONAI>(arg0, 6, b"ELONAI", b"ElonAi", b"Combination of two narratives", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_output_ef1d641d01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

