module 0x7b1d9db8f0595b4ea5008efa5a0db37779bfcc353bbac500a9aebfa22bd3b983::pngmi {
    struct PNGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNGMI>(arg0, 6, b"PNGMI", b"Papi Peng NGMI", b"Papi Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2482_0f71f3d0b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

