module 0x3bee8a4785a3e32b182dd7a770fcbb2c6556b797eb7d0b1f8e3ff170b12ddee2::shitsui {
    struct SHITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITSUI>(arg0, 6, b"SHITSUI", b"Shit Sui", b"Shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit shit!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250503_005830_677a22fd86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

