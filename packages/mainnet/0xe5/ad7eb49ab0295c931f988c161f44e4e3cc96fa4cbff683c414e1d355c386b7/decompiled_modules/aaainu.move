module 0xe5ad7eb49ab0295c931f988c161f44e4e3cc96fa4cbff683c414e1d355c386b7::aaainu {
    struct AAAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAINU>(arg0, 6, b"AAAINU", b"AAA INU", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_14_11_58_14_426692be70_9a9ecca8b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

