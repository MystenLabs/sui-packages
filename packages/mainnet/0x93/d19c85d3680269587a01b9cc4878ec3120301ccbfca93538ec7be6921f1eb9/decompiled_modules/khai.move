module 0x93d19c85d3680269587a01b9cc4878ec3120301ccbfca93538ec7be6921f1eb9::khai {
    struct KHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAI>(arg0, 6, b"KHAI", b"KittenHaimer", b"IM THE ADVENTURER KITTEN HERE AT CRYPTO WORLDDDDDD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GARFIELD_f222b47692.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

