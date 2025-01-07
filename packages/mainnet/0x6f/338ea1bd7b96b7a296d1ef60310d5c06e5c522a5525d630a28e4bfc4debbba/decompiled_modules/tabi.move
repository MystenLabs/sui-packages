module 0x6f338ea1bd7b96b7a296d1ef60310d5c06e5c522a5525d630a28e4bfc4debbba::tabi {
    struct TABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TABI>(arg0, 6, b"TABI", b"TABI INU SUI", b"$TABI - Inspired by SUI coin, on a mission to free the city from taxes. Community-driven rebellion, built on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Eg_i_Al_400x400_0552c7fa1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

