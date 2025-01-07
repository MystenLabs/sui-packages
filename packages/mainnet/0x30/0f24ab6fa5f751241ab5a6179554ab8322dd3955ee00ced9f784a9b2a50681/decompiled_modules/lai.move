module 0x300f24ab6fa5f751241ab5a6179554ab8322dd3955ee00ced9f784a9b2a50681::lai {
    struct LAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAI>(arg0, 6, b"LAI", b"LEGO AI", b"Darkness LEGO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_A_Ljw9_Iky_1729056201977_raw_229f681452.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

