module 0xe1aef2ec65608f2b4bc3da5457746049d5586e6f9c387d35a31ebf05571c0c31::o_sail_token {
    struct O_SAIL_TOKEN has drop {
        dummy_field: bool,
    }

    fun create_currency(arg0: O_SAIL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<O_SAIL_TOKEN> {
        let (v0, v1) = 0x2::coin::create_currency<O_SAIL_TOKEN>(arg0, 6, b"oSAIL", b"FullSail Option", b"Option token that can be executed in order to get SAIL with discount", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://link.to.logo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O_SAIL_TOKEN>>(v1);
        v0
    }

    fun init(arg0: O_SAIL_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<O_SAIL_TOKEN>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0xe1aef2ec65608f2b4bc3da5457746049d5586e6f9c387d35a31ebf05571c0c31::allow_list::init_rule<O_SAIL_TOKEN>(&v3, &mut v4, arg1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<O_SAIL_TOKEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O_SAIL_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<O_SAIL_TOKEN>(v4);
    }

    // decompiled from Move bytecode v6
}

