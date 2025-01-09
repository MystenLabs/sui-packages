module 0x9527d9c36ff0f2ae8b156ce46e59d2cc838f15da81a73fd5f9e5988177ffdc04::rdwhcto {
    struct RDWHCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDWHCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDWHCTO>(arg0, 6, b"RDWHCTO", b"RUSSIAN DOG WIF HAT CTO", b"This mfkr rekted us, this CYKA blyat will cry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009998_7f949c7e06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDWHCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDWHCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

