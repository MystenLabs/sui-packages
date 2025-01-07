module 0x455f6adfc09f169f04b31347df5b45e307c202ba4c7a385bee9168c473328925::krabby {
    struct KRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABBY>(arg0, 6, b"Krabby", b"Krabby By Matt Furie", x"496e204d61747420467572696527732027546865204e69676874205269646572732c272043524142425920697320746865204d61696e2056696c6c61696e20746861742063686173657320486f70707920616e642074686520637265772061726f756e642e204372616262792069732061206875676520616e642068756e6772792c2062757420616c736f20637574652063726162210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Po_YM_1_R_Dz_400x400_5971071b5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

