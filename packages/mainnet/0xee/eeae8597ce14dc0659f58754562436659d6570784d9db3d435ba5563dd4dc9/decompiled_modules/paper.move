module 0xeeeeae8597ce14dc0659f58754562436659d6570784d9db3d435ba5563dd4dc9::paper {
    struct PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPER>(arg0, 6, b"Paper", b"Paper Hands CTO", b"Token for diamond hands against Paper hands on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_N_D_N_D_D_D_2024_10_08_190157_10e7921254.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

