module 0xf6782ee807b6a2800b10ec74b3aba072e99aaa45d8d343882766fed815674b83::fratt {
    struct FRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRATT>(arg0, 6, b"FRatt", b"Frogg Ratt", b"Frogg & Ratt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FROG_fc26562acb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

