module 0x62847717cace25ac03d42dcbb36de55dcf22f2a9b3e4b3a353004fcf29812aa5::suichat {
    struct SUICHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAT>(arg0, 6, b"SUICHAT", b"Sui Chat", b"SuiChat prioritizes user privacy and security through robust encryption protocols, ensuring confidentiality during communication. Users retain full control over their data, reducing the risk of breaches or unauthorized access.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8922_e1c7e52916.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

