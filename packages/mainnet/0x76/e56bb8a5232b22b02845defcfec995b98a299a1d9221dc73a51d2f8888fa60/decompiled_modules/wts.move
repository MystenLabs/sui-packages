module 0x76e56bb8a5232b22b02845defcfec995b98a299a1d9221dc73a51d2f8888fa60::wts {
    struct WTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTS>(arg0, 6, b"WTS", b"what the sigma", b"ermmm... what the sigma??", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7hnvy_Hf_Kuw_Xz_W_Cnvtn57_KFK_6_XU_7_Ruzf6_Jetvon_GD_8pac_19cb3e28c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

