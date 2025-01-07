module 0x2f783956012ef0601d25f2196ec821c7234b86fbcf285763a7f90e4785e2a493::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"superman on sui", x"245375696d616e2069732061206d656d6520746f6b656e2074686174206d697865732073757065726865726f20737472656e677468207769746820636c657665726e65737320746f2073617665207468652063727970746f76657273652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730304547419_898f7bfb6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

