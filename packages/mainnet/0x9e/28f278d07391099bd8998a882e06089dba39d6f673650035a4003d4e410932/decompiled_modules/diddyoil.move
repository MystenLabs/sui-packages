module 0x9e28f278d07391099bd8998a882e06089dba39d6f673650035a4003d4e410932::diddyoil {
    struct DIDDYOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDYOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDYOIL>(arg0, 6, b"DIDDYOIL", b"DIDDY OIL", b"50 Cent trolls Diddy and his 1,000 bottles of lube and baby oil found in federal raid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Vx_k_I_Xs_A_Am4f_L_ef85223f0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDYOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDYOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

