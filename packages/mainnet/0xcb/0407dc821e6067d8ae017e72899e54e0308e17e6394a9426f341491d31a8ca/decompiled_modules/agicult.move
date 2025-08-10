module 0xcb0407dc821e6067d8ae017e72899e54e0308e17e6394a9426f341491d31a8ca::agicult {
    struct AGICULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGICULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGICULT>(arg0, 9, b"AGI", b"AGI cult", b"URI: https://rapidlaunch.io/temp/metadata/e54bde67-d29f-4daa-8103-0e4cfa1355fb.json", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://rapidlaunch.io/temp/metadata/e54bde67-d29f-4daa-8103-0e4cfa1355fb.json")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AGICULT>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGICULT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGICULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

