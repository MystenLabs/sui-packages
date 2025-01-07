module 0x99673cad4329b2befd29a00d0cf67cebccb6acbbbf6c6852e032c3d0ef55570a::hugecock {
    struct HUGECOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGECOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGECOCK>(arg0, 6, b"Hugecock", b"Suing huge cock", b"Suing my hude cock around dgaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_14_at_17_27_37_26514f04_4439b62c45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGECOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUGECOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

