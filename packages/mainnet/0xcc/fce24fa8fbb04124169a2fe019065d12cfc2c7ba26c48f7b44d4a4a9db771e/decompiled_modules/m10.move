module 0xccfce24fa8fbb04124169a2fe019065d12cfc2c7ba26c48f7b44d4a4a9db771e::m10 {
    struct M10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: M10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M10>(arg0, 6, b"M10", b"Messi", b"Messi fan token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AI_nh_ma_I_n_hi_I_nh_2024_10_08_lu_I_c_19_29_52_e54018d0ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M10>>(v1);
    }

    // decompiled from Move bytecode v6
}

