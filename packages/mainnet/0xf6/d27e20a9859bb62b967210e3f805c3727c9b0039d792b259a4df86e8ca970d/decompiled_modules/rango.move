module 0xf6d27e20a9859bb62b967210e3f805c3727c9b0039d792b259a4df86e8ca970d::rango {
    struct RANGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANGO>(arg0, 6, b"RANGO", b"Rango SUI", x"4d6565742052616e676f2c20656d65726765642066726f6d2074686520535549204a756e676c65206865726520746f206b65657020796f75206168656164206f66207468652063757276652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v0_Wv_X4u_D_400x400_879afdc226.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RANGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

