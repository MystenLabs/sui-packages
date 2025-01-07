module 0x710646753b5a5f93ff8872e59b7c4bae05e0ad8b2ca3bba8b7901938c396c405::lug {
    struct LUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUG>(arg0, 6, b"Lug", b"beluga", b"beluga the cute whale exploring the sui ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beluga_whale_webcam_9_6d959b517f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

