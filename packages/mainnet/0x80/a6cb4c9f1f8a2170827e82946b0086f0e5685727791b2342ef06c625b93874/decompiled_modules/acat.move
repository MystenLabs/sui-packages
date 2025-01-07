module 0x80a6cb4c9f1f8a2170827e82946b0086f0e5685727791b2342ef06c625b93874::acat {
    struct ACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACAT>(arg0, 6, b"ACAT", b"Anonymous Cat", b"Cat is anonymous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0663_5ba37f53d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

