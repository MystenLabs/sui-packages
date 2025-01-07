module 0x48cc8964b3c12f8a4f197a33af2b48c4f3145905bda24963ad512f67b86be3e8::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 6, b"MCAT", b"MOONCATSUI", b"Immortalizing the moon culture in $MCAT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uw_B_Ra_ZG_7_400x400_977d3f6168.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

