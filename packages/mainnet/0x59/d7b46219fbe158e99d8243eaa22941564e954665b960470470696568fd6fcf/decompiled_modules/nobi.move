module 0x59d7b46219fbe158e99d8243eaa22941564e954665b960470470696568fd6fcf::nobi {
    struct NOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBI>(arg0, 6, b"NOBI", b"NOBI ON SUI", b"The OG Cat Coin on Sui, Get in on the ground floor with Sui Cat and be part of the OG cat coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_79_688d7be305.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

