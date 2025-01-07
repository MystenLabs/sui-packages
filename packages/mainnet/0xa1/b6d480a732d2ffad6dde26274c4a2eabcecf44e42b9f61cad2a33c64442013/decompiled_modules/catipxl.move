module 0xa1b6d480a732d2ffad6dde26274c4a2eabcecf44e42b9f61cad2a33c64442013::catipxl {
    struct CATIPXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATIPXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATIPXL>(arg0, 9, b"CATIPXL", b"Cati Pixel", b"CatiPxl on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebbbdb07-de6f-434e-a928-32e7ab13d95d-how-to-train-your-dragon-pixel-art-8bit-dragon-dreamworks-dragons-how-to-train-your-dragon-pixel-pixel-art-5a24f9c0f6c96a8d29720dd3.brickImg.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIPXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATIPXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

