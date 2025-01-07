module 0x867bd3f8e91d21e0b1638d1070fc7629113d42fee3933d5f12715dc512640ac5::stonk6900 {
    struct STONK6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONK6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONK6900>(arg0, 6, b"STONK6900", b"SUI TONK6900", b"$STONK6900 ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ct_Hs_Azx_400x400_b9e773de7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONK6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONK6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

