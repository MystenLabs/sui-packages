module 0x3ac2b6117bfdce2e481d8b61ae5d2106baf863a009a74e144ce5aad71c1b9610::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BullShark", b"Meet the fastest creature in the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5942916659901744295_c_cabd87b102.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

