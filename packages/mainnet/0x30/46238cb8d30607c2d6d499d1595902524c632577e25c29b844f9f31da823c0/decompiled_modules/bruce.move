module 0x3046238cb8d30607c2d6d499d1595902524c632577e25c29b844f9f31da823c0::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"Bruce The Sharky", x"5468652063757465737420616e642062616464657374206d666572206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7pu_YG_Xv_E_400x400_0e1dd5b441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

