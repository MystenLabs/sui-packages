module 0x97d8738c751b68f5f16304cff8d894fd64c64bca2436f35106fc92964d121ec::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGI>(arg0, 6, b"AGI", b"$Ass Grabbing Intelligence", b"Ass Grabbing Intelligence (AGI)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rjqe6w81mf_Av_E3j_AVKVRB_8ixaq_HQBQM_Fa_U_Nx_Z_Us_T_Wj_Ce_6950ac0f80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

