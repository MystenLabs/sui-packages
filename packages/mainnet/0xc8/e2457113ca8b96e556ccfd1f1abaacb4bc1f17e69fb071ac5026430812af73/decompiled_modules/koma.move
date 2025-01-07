module 0xc8e2457113ca8b96e556ccfd1f1abaacb4bc1f17e69fb071ac5026430812af73::koma {
    struct KOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMA>(arg0, 6, b"KOMA", b"KOMA SUI", b"Fans love watching Komas expressions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_26_888480325d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

