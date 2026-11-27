module 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::positions {
    struct ActivePosition has store {
        coin_type_0: 0x1::type_name::TypeName,
        coin_type_1: 0x1::type_name::TypeName,
        protocol: u8,
        pool: address,
        position_id: 0x2::object::ID,
        mint_amount_0: u64,
        mint_amount_1: u64,
    }

    struct PositionKey has copy, drop, store {
        executor: address,
    }

    public fun active_position_of(arg0: &0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::Vault, arg1: address) : (u8, address, 0x2::object::ID, u64, u64) {
        let v0 = 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::uid(arg0);
        assert!(has_position(v0, arg1), 1);
        let v1 = PositionKey{executor: arg1};
        let v2 = 0x2::dynamic_field::borrow<PositionKey, ActivePosition>(v0, v1);
        (v2.protocol, v2.pool, v2.position_id, v2.mint_amount_0, v2.mint_amount_1)
    }

    public fun has_active_position(arg0: &0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::Vault, arg1: address) : bool {
        has_position(0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::uid(arg0), arg1)
    }

    fun has_position(arg0: &0x2::object::UID, arg1: address) : bool {
        let v0 = PositionKey{executor: arg1};
        0x2::dynamic_field::exists_with_type<PositionKey, ActivePosition>(arg0, v0)
    }

    public(friend) fun set_mint_basis(arg0: &mut 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::Vault, arg1: address, arg2: u64, arg3: u64) {
        let v0 = PositionKey{executor: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, ActivePosition>(0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::uid_mut(arg0), v0);
        v1.mint_amount_0 = arg2;
        v1.mint_amount_1 = arg3;
    }

    public(friend) fun store<T0: store + key>(arg0: &mut 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::Vault, arg1: address, arg2: T0, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u8, arg6: address) {
        let v0 = 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::uid_mut(arg0);
        assert!(!has_position(v0, arg1), 0);
        let v1 = PositionKey{executor: arg1};
        let v2 = ActivePosition{
            coin_type_0   : arg3,
            coin_type_1   : arg4,
            protocol      : arg5,
            pool          : arg6,
            position_id   : 0x2::object::id<T0>(&arg2),
            mint_amount_0 : 0,
            mint_amount_1 : 0,
        };
        0x2::dynamic_field::add<PositionKey, ActivePosition>(v0, v1, v2);
        let v3 = PositionKey{executor: arg1};
        0x2::dynamic_object_field::add<PositionKey, T0>(v0, v3, arg2);
    }

    public(friend) fun take<T0: store + key>(arg0: &mut 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::Vault, arg1: address) : (T0, 0x1::type_name::TypeName, 0x1::type_name::TypeName, u8, address, 0x2::object::ID, u64, u64) {
        let v0 = 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::vault::uid_mut(arg0);
        assert!(has_position(v0, arg1), 1);
        let v1 = PositionKey{executor: arg1};
        let ActivePosition {
            coin_type_0   : v2,
            coin_type_1   : v3,
            protocol      : v4,
            pool          : v5,
            position_id   : v6,
            mint_amount_0 : v7,
            mint_amount_1 : v8,
        } = 0x2::dynamic_field::remove<PositionKey, ActivePosition>(v0, v1);
        let v9 = PositionKey{executor: arg1};
        (0x2::dynamic_object_field::remove<PositionKey, T0>(v0, v9), v2, v3, v4, v5, v6, v7, v8)
    }

    // decompiled from Move bytecode v7
}

