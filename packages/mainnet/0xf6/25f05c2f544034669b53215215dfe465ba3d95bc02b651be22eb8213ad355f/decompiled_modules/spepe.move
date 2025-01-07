module 0xf625f05c2f544034669b53215215dfe465ba3d95bc02b651be22eb8213ad355f::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 6, b"SPepe", b"Snow Pepe", b"This pepe is ready for the snow! Let it snow! let it snow! let it snow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Erqy_DX_Pq3csgm_Je_Nnd3_Pvq_Dqz_GB_Yt5g_Ux_Nv9_Hb9_Mcn_Xr_d92f4f5bb1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

