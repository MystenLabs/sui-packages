module 0x959b3d385036c915a23a0534c9a890bc038fd6e59c32e2ed9faebe80dc2012a8::schrodinger {
    struct SCHRODINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHRODINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHRODINGER>(arg0, 6, b"SCHRODINGER", b"Elon Musk's Cat", b"Elon Musk's Cat was name after Schrodinger, was a Nobel Prizewinning Austrian and naturalized Irish physicist who idolize by Elon Musk who developed fundamental results in quantum theory. In particular, he is recognized for postulating the Schrdinger equation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elon_musk_cat_93e9b71144.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHRODINGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHRODINGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

