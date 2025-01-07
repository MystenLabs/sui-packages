module 0xe396c74dfcb72397caae38440bfc70b2e102dc3184a440273cbd3c648011dc88::carp {
    struct CARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARP>(arg0, 6, b"CARP", b"CARP SUI", x"496e20244341525020436976696c697a6174696f6e2c20796f75206861766520746f207377696d20666f7220746865207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_63_7c58f339f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

