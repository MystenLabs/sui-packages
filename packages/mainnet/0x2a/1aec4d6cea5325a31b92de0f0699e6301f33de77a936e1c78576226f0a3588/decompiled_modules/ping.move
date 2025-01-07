module 0x2a1aec4d6cea5325a31b92de0f0699e6301f33de77a936e1c78576226f0a3588::ping {
    struct PING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PING>(arg0, 6, b"PING", b"PING SUI", b"A cute little dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_37_dfa72ee6a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PING>>(v1);
    }

    // decompiled from Move bytecode v6
}

