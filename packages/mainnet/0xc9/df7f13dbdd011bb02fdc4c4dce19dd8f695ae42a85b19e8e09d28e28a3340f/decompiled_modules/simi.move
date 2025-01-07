module 0xc9df7f13dbdd011bb02fdc4c4dce19dd8f695ae42a85b19e8e09d28e28a3340f::simi {
    struct SIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMI>(arg0, 6, b"SIMI", b"SUIMI", b"SIMI comes from the sound cats make and reflects a tradition of doubling words to express endearment and fondness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_93_7dd3f385b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

