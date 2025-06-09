module 0x22680b1a24a03d0b2a551501514e9328370b985d590cf3b32b3314bb39e5de5d::SheGreen {
    struct SHEGREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEGREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEGREEN>(arg0, 9, b"She", b"SheGreen", b"she is green", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a6b21a13-e5ff-425c-b39d-8747c9bec92c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEGREEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEGREEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

