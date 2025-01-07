module 0x9b1f8e3132771588a080b272be255c60988a675c4d357a8761b26973e4288e27::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SuiDog", b"Sui Dog", b"The Dog comes to Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2210_m05_ig14_n015_mainpreview_1065b8e0ba02a33d74f8a85478cd4c995c8a9fc9117d1b024f4d1ba361ca4fca_75592cb1b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

