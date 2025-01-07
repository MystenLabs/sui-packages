module 0xbc839cfa674ca486c7879f18de4d246a7411fa87afe247d6cfdfca210784c65c::nwif {
    struct NWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWIF>(arg0, 6, b"NWIF", b"NEIROWIFHAT ON SUI", b"Just a Neiro wif a hat on SUI. From the Neiro Community to the whole world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_28_1a190f74d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

