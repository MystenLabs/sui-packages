module 0x441f7bdc8158093e73281790f35d960d5d30f89a152cb6a87990e297c64bd4bc::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"PEPSUI", b"PEPE SUI", b"ROTATE PEPE SUI DEVELOPER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_Oct_16_Frog_in_Business_Suit_7496eac43b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

