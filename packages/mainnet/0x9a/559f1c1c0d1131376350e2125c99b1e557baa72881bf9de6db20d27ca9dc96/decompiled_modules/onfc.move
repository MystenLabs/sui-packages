module 0x9a559f1c1c0d1131376350e2125c99b1e557baa72881bf9de6db20d27ca9dc96::onfc {
    struct ONFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONFC>(arg0, 9, b"ONFC", b"jejs", b"jene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90940a14-5f64-4a40-a37d-f7e227f853cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

