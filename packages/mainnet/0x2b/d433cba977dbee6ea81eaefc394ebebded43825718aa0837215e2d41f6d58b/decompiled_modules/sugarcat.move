module 0x2bd433cba977dbee6ea81eaefc394ebebded43825718aa0837215e2d41f6d58b::sugarcat {
    struct SUGARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGARCAT>(arg0, 6, b"Sugarcat", b"Sugardaddy Cat", b"Rich old cat... sugar caddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zc5_XT_Ra0_A_Axd_Xi_e32a0cf389.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

