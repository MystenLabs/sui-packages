module 0x605436fa4dbee584d8453ebd24fe6796ef771d523448cf4f536bae3d0141ebbd::burned {
    struct BURNED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNED>(arg0, 9, b"BURNED", b"BURN", b"will burned", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BURNED>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNED>>(v2, @0x8fcf67efb64adc9d5b84e33f4ec8ea8a363a8e1c50bb9df22a823078842f7145);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNED>>(v1);
    }

    // decompiled from Move bytecode v6
}

