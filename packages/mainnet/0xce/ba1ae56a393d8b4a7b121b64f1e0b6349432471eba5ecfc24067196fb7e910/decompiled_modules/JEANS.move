module 0xceba1ae56a393d8b4a7b121b64f1e0b6349432471eba5ecfc24067196fb7e910::JEANS {
    struct JEANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEANS>(arg0, 6, b"Sydney Sweeney", b"JEANS", b"She has really good jeans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/781fae14-cf8e-44db-ae29-6575bcb09214")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEANS>>(v0, @0xd7bf891161151dcf6c9125256a8a60043912d4c072744003314ea182c1ee96e9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

