module 0x8d2b112344cb6e19949d0f3b46f639d6d1e8b935b3dcc59186f9c4888a36e1ef::hedgey {
    struct HEDGEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDGEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDGEY>(arg0, 6, b"Hedgey", b"hedgy the hedgehog", b"wen sun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b0a418a0_b17c_11ef_84e6_298a2db62aed_jpg_copy_94cfbec597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDGEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEDGEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

