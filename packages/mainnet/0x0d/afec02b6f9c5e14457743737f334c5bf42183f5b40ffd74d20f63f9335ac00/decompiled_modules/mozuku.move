module 0xdafec02b6f9c5e14457743737f334c5bf42183f5b40ffd74d20f63f9335ac00::mozuku {
    struct MOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZUKU>(arg0, 6, b"MOZUKU", b"MOZUKU SUI", b"now are you sure that Mozuku it is a real name of Doge ? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_43_1f43d3d973.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

