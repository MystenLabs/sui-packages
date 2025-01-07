module 0x1b0c97689f7bd1f0f4985b82acfee603daa48fcd55c1b9b694cc989c0f76556b::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND>(arg0, 6, b"Diamond", b"Sui Diamond", b"One mission: become the most expensive diamond in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Pkx_Mf_A2_400x400_de8c882f65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

