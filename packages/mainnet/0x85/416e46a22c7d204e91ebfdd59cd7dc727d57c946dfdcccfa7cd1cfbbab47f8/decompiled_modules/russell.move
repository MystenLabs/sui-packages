module 0x85416e46a22c7d204e91ebfdd59cd7dc727d57c946dfdcccfa7cd1cfbbab47f8::russell {
    struct RUSSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSELL>(arg0, 6, b"RUSSELL", b"RUSSELL SUI", b"#Russell Brian Armstrong's Dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_27_bbcca2addd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

