module 0x86faf8ef3f3dc15be1a586533e28ccb641903b71d70a59715f98f90526da0cfd::gmcat {
    struct GMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMCAT>(arg0, 6, b"GMCAT", b"GMCAT on SUI", b"The official mascot of @gm_dot_ai ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tlc_R9_ZU_3_400x400_b2539af8d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

