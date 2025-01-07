module 0x9319447b4aaa23f42b804fe42eb32d799ea14af3e7942f81f255ea0ae3088d72::suisunnn {
    struct SUISUNNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUNNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUNNN>(arg0, 6, b"Suisunnn", b"SunZilla", b"SUISUNSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gigapixel_justin_sun_excuses_gigapixel_standard_v2_4x_92268ee80a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUNNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUNNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

