module 0xc24225656b83708a38a8aa964a3525036e5418b55728b8107f6cd8bd2c84a59b::baltcat {
    struct BALTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALTCAT>(arg0, 6, b"BALTCAT", b"BALT CAT SUI", b"First Balt on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_3_95f4cfbba2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALTCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

