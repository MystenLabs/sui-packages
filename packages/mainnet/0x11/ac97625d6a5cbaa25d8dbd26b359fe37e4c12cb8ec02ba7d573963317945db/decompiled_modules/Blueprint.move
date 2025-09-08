module 0x11ac97625d6a5cbaa25d8dbd26b359fe37e4c12cb8ec02ba7d573963317945db::Blueprint {
    struct BLUEPRINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPRINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPRINT>(arg0, 9, b"BLUE", b"Blueprint", b"The blue prints ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-fun.sgp1.cdn.digitaloceanspaces.com/TemporaryCoinAvatar/01K4KAMDX17QVEN8VNQ47YS7RS.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEPRINT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPRINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

