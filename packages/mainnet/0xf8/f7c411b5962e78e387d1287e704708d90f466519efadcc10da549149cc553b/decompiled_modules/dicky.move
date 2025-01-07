module 0xf8f7c411b5962e78e387d1287e704708d90f466519efadcc10da549149cc553b::dicky {
    struct DICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKY>(arg0, 6, b"DICKY", b"DICKY SUI", x"244469636b7920746865206d6f737420626164617373206475636b206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_34_7073971db4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

