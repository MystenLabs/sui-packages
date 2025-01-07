module 0xd65cfd2f150e929bb1a4445949056a3a65cc5fde715a70f05c937e4fa185c60c::epikduck {
    struct EPIKDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPIKDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPIKDUCK>(arg0, 6, b"EPIKDUCK", b"SUIEPIKDUCK", x"4475636b20746f2061206275636b205741484f4f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_42_307f59baa8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPIKDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPIKDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

