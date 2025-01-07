module 0xe8ab428fae90fc622198afed140cd3f5ad5dacddfedb589620e41ef3e8f8049c::brainsui {
    struct BRAINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINSUI>(arg0, 6, b"BRAINSUI", b"BRIAN GRIFFIN", b"$BRIANSUI - Brian Griffin is finally making his way to the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_89_5cc15f7df6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

