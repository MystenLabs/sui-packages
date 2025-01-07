module 0xc696e7cca9eb5034ac1ee8bd24a385725596c9c2ae61b3e51624e0f5c7fd8c28::sisnr {
    struct SISNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SISNR>(arg0, 6, b"Sisnr", b"Suisenor", b"No speaky, si senor. Drops and plops meet sombreros and sui. Community driven check the telegram.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0544_1ad80a13fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SISNR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISNR>>(v2);
    }

    // decompiled from Move bytecode v6
}

