module 0x3dea005f52f4397b9ee9bc7de8751dc9ede7367a44d0257918f0581d93580c38::yoda {
    struct YODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YODA>(arg0, 6, b"YODA", b"YODA SUI", b"YODA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_17_7b881d558a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

