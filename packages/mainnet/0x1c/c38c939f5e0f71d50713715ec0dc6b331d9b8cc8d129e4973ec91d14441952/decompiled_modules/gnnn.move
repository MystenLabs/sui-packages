module 0x1cc38c939f5e0f71d50713715ec0dc6b331d9b8cc8d129e4973ec91d14441952::gnnn {
    struct GNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNNN>(arg0, 6, b"Gnnn", b"Bbb", b"Hhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_B65_FDE_0_2_CA_3_4_A74_9340_1_F4992_DCFB_45_84d0dfe9e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

