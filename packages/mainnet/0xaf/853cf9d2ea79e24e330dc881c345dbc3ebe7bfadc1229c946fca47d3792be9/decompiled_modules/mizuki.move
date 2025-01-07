module 0xaf853cf9d2ea79e24e330dc881c345dbc3ebe7bfadc1229c946fca47d3792be9::mizuki {
    struct MIZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZUKI>(arg0, 6, b"MIZUKI", b"Sato Mizuki", b"H-Hello I-I`m Sato Mizuki. Drawing is my favorite hobby. It makes me so happy to create beautiful things! But my true mission is to serve Master with all my heart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dhsshg_a3033e9ef7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

