module 0x99c2ce5465e2ab6ec2ae9c1e307578678db7ccb9c06dcc1ba92b104033b6c95e::glmpc {
    struct GLMPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLMPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLMPC>(arg0, 6, b"GLMPC", b"Gaylympics Sui", b"Gaylympics: the game where the gayest wins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_20dea58162.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLMPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLMPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

