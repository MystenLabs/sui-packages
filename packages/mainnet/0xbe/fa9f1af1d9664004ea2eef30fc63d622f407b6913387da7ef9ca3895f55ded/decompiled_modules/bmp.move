module 0xbefa9f1af1d9664004ea2eef30fc63d622f407b6913387da7ef9ca3895f55ded::bmp {
    struct BMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMP>(arg0, 6, b"BMP", b"Blue Move Pump", b"OFFICIAL BLUEMOVE TOKEN ON MOVEPUMP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sk_Agauhd_400x400_1_f6ce3b686e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

