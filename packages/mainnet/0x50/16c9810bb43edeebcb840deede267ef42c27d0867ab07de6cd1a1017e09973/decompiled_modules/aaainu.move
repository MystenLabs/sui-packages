module 0x5016c9810bb43edeebcb840deede267ef42c27d0867ab07de6cd1a1017e09973::aaainu {
    struct AAAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAINU>(arg0, 6, b"AAAINU", b"AAA INU", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_11_58_14_426692be70_9eac955a0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

