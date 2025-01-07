module 0x5a1427c09fe0670a592b59bc33a7b7c85f911c592c62ca1a888babdcba2bfca8::spei {
    struct SPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEI>(arg0, 6, b"SPEI", b"SUIPEI", b"SUIPEI is here to break boundaries and capture hearts, and were thrilled to have you join us on this journey to the moon and beyond!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/new_1_88f710c058.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

