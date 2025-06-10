module 0x2e187e29d8a3b09d9b0913045e9f2fc995d2f32321e5e62aad70713254fee28c::yghjghj {
    struct YGHJGHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGHJGHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGHJGHJ>(arg0, 9, b"mhvgjhgj", b"yghjghj", b"jgjhgjhghjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/6825f816-b495-493c-ad84-f076c4646e61.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YGHJGHJ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGHJGHJ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

