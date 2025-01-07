module 0x73f5b9375d918756d3acd809cda9d0955deb65f09ed8f65b004b4f9e6168485d::suihor {
    struct SUIHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOR>(arg0, 6, b"SUIHOR", b"SUIHORSE", b"SUIHORSE, once a fascinating sea creature, now swims upright in the SUI marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_18_31_29_ad8d4051c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

