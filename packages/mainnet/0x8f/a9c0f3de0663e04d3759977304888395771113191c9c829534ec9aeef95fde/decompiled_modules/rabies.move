module 0x8fa9c0f3de0663e04d3759977304888395771113191c9c829534ec9aeef95fde::rabies {
    struct RABIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABIES>(arg0, 6, b"Rabies", b"Rabies on SUI", x"4974277320636f6e746167696f7573210a0a537072656164696e6720666173742066726f6d206d656d6520746f206d656d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J_Pdy_PP_7n_400x400_6d649c2bb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

