module 0x2b05a3d2605b339a51ab482bae3860ebe5c0ac494a248e51c3eb66a965018eba::sisnr {
    struct SISNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISNR>(arg0, 6, b"Sisnr", b"Suisenor", b"Welcome to the sombrero army of drops and plops, check the tg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0544_d13be2f943.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

