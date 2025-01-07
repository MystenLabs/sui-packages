module 0x21873553778c898c626f0376847bdb6fda70142e00d74d71ec38047811119ce5::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"ICELIA SUI", b" LET'S MAKE EVERYONE A WINNER ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/41beb_SE_Fc_BAY_4_Pk5k3u_T7_ZMY_Aj_JJ_Ur_Ub3gd_E_Wvt3pump_f1db1837be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

