module 0x4d912fb6c57f04c3a741e9d1b1d43f77141ab2f9f0bd66ee49ea29987a5c2acf::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"bro WTF", b"WTF IS GOING ON TO THE MOON AND BEYOND,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23423_395bdf24b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

