module 0xfcd2a782a32b15aad80e24be0e0b11a38461b3955f096074932ad8ce17893973::glow {
    struct GLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOW>(arg0, 6, b"GLOW", b"Glow In The Dark", b"THIS GUY GLOW IN THE DARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/51_Tl_K5_HR_Rz_L_AC_UF_894_1000_QL_80_8146b1dcd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

