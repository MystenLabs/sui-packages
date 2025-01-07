module 0xbf37208c1dfebcf51b82928526008ffb18cbcf3e1cd1c1c2e8ce821917de7b00::sbs {
    struct SBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBS>(arg0, 6, b"SBS", b"Sui Birds", x"746865206669727374206372792d426972647320746f2073657420706177206f6e207468652053756920626c6f636b636861696e2e204d79206d697373696f6e3f20546f20626520796f757220707572722d66656374206775696465207468726f756768207468697320736c65656b206469676974616c2066726f6e746965722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4014_45cd57ca12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

