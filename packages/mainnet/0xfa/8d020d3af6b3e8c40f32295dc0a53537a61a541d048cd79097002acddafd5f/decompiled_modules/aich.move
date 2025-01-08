module 0xfa8d020d3af6b3e8c40f32295dc0a53537a61a541d048cd79097002acddafd5f::aich {
    struct AICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICH>(arg0, 6, b"AICH", b"ArchAI by SuiAI", b"The Architect, constructor of the metaverse superstructure, master of hallways, king of corners.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/M8618t_Up3_Px_VPBKJ_8u_Cv_1_9y84i_f3d6b7b37c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

