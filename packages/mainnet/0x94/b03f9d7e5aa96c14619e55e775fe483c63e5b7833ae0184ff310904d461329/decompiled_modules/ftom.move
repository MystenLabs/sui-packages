module 0x94b03f9d7e5aa96c14619e55e775fe483c63e5b7833ae0184ff310904d461329::ftom {
    struct FTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTOM>(arg0, 6, b"FTOM", b"Funtom", x"4465782061676772656761746f722c537761702c4661726d2026204c61756e6368706164206d656d65636f696e207375690a46726f6d204d656d657320746f204d696c6c696f6e733a2046756e746f6d7320416c6c2d696e2d4f6e652043727970746f20487562204f6e2023537569204e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_DM_Zy_Y5_I_400x400_23596c0825.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

