module 0x8246d68cb61af4e76d6d2828819daf2702b9b02c4634fbf9beab4c7c25d5ed8a::iago {
    struct IAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAGO>(arg0, 6, b"IAGO", b"SUI IAGO", x"54686520657261206f6620746865206d6967687479204961676f2c20746865206d6f73742063756e6e696e67206d656d65206269726420657665722e204d616465206279204d797374656e204c6162732050696374757265732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Au3i4_Dh9_U_Kb6_S_Kg1_Sc_VA_Dc_Xw_Fdawesq72b52_Mpmapump_ccab684408.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

