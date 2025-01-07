module 0xb9b85a9cfb3a28a1bb77d55f0b3791bfa8ef60782a4ad364b0bde63c60a9f2f9::suidick {
    struct SUIDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDICK>(arg0, 6, b"SuiDick", b"ButtDick", b"Dickbutt has officially arrived on Sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge_Z_Vo_Hy_Xs_A_Acj8t_534d016abf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

