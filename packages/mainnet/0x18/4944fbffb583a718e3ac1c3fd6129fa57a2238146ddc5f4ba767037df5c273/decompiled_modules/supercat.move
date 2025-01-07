module 0x184944fbffb583a718e3ac1c3fd6129fa57a2238146ddc5f4ba767037df5c273::supercat {
    struct SUPERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCAT>(arg0, 6, b"SUPERCAT", b"SUPER CAT SUI", b"Courage the paranoia dog turn blue while trading base.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_00_57_02_b973736e3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

