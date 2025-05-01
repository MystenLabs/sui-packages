module 0x668aee693dbb92ed8cab97358fd2b8b2ff942d6fa4b9336731ce9ec8377afc98::attn {
    struct ATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTN>(arg0, 6, b"ATTN", b"The Attention Token", b"Proof of attention.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F9nck_Qek_Jxjq9fwu_Vn_JGH_168jaee_Gvi_Nx1i_MN_Qespump_2_cd26ea971b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

