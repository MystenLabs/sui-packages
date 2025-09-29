module 0x5153c1b9267dd1ec154d076c87c1a4c62e5266d184f9168bf0888388495f7455::custom_token_pool {
    struct CustomTokenPoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct CUSTOM_TOKEN_POOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTOM_TOKEN_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CustomTokenPoolAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CustomTokenPoolAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

