module 0x8dd9be324a47cf5d4bc9b7981547f3213caa3fe72e6ed1d04b233dbdbbed7c15::suirca {
    struct SUIRCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRCA>(arg0, 6, b"SUIRCA", b"Sui Orca", x"4d65657420537569726361202824535549524341292c207468652061706578207072656461746f72206f6620537569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_91_64b8e7b949.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

