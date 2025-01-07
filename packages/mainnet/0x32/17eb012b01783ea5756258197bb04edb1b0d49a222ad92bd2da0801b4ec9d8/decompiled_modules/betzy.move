module 0x3217eb012b01783ea5756258197bb04edb1b0d49a222ad92bd2da0801b4ec9d8::betzy {
    struct BETZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETZY>(arg0, 6, b"BETZY", b"BetzySUI", b"Betzy is your good-luck memecoin and digital companion that spreads fortune and fosters connections among Web3 gamers and gamblers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbddu2tj_Xk_Rp_XEPD_Sc_Mideywo5d_X5j_V2x_Skxd5_G_Nh_Fe_Kg_b367c9f98b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

