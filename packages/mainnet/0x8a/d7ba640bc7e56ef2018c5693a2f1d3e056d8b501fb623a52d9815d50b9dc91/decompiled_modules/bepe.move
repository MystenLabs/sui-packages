module 0x8ad7ba640bc7e56ef2018c5693a2f1d3e056d8b501fb623a52d9815d50b9dc91::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE>(arg0, 6, b"Bepe", b"Baby Bepe", b"Baby Pepe was just born on Sui to follow the footsteps of his daddy and take over the Space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_18f6b8e13e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

