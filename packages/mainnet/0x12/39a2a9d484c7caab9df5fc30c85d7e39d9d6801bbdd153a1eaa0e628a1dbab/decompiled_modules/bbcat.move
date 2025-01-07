module 0x1239a2a9d484c7caab9df5fc30c85d7e39d9d6801bbdd153a1eaa0e628a1dbab::bbcat {
    struct BBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBCAT>(arg0, 6, b"BBCAT", b"baby cat", b"baby cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_bfe3bc503f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

