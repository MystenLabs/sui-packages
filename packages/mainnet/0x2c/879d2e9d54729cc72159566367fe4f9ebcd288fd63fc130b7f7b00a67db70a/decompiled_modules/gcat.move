module 0x2c879d2e9d54729cc72159566367fe4f9ebcd288fd63fc130b7f7b00a67db70a::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 6, b"GCat", b"Gold Cat", x"74686520666972737420476f6c6443617420746f2073657420706177206f6e207468652053756920626c6f636b636861696e2e204d79206d697373696f6e3f20546f20626520796f757220707572722d66656374206775696465207468726f756768207468697320736c65656b206469676974616c2066726f6e746965722e0a68747470733a2f2f782e636f6d2f476f6c646361747375690a68747470733a2f2f742e6d652f476f6c64636174737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4030_941a6ea1c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

