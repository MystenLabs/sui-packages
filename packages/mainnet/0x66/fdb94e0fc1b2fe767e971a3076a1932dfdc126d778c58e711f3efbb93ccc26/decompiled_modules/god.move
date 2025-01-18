module 0x66fdb94e0fc1b2fe767e971a3076a1932dfdc126d778c58e711f3efbb93ccc26::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"Gains Of Donald by SuiAI", b"WE NEED MORE GAINS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Qm_X_Qf_Zko_Z_Zr61jtwi_N_Nve3x7_Pr_Ke_X_Qe_Ds_Lo_V4b98xb_Quf9_b9b290dbd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

