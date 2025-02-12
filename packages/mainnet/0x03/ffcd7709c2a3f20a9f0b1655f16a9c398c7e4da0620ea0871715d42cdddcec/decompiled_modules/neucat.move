module 0x3ffcd7709c2a3f20a9f0b1655f16a9c398c7e4da0620ea0871715d42cdddcec::neucat {
    struct NEUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEUCAT>(arg0, 6, b"NEUCAT", b"Neural Cat on Sui", b"Neural Cat AI AGENT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_18_a6cc6670a6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

