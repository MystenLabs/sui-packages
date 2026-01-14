module 0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::receipt {
    struct Receipt {
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        sqrt_price: u128,
        liquidity: u128,
        source: u64,
        vault: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        payload: vector<u8>,
    }

    public fun amount_x(arg0: &Receipt) : u64 {
        arg0.amount_x
    }

    public fun amount_y(arg0: &Receipt) : u64 {
        arg0.amount_y
    }

    public fun destroy_receipt(arg0: Receipt, arg1: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::ProxyCap) : (address, 0x2::object::ID, 0x2::object::ID, u64, u64, u128, u128, u64, 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, vector<u8>) {
        let Receipt {
            owner       : v0,
            pool_id     : v1,
            position_id : v2,
            amount_x    : v3,
            amount_y    : v4,
            sqrt_price  : v5,
            liquidity   : v6,
            source      : v7,
            vault       : v8,
            payload     : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun liquidity(arg0: &Receipt) : u128 {
        arg0.liquidity
    }

    public fun new_receipt(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u128, arg6: u128, arg7: u64, arg8: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg9: vector<u8>, arg10: &0x56aacf316e08562cd1c085a48d12be8f5510fd3eee31226ef07af0548ba79868::registry::ProxyCap) : Receipt {
        Receipt{
            owner       : arg0,
            pool_id     : arg1,
            position_id : arg2,
            amount_x    : arg3,
            amount_y    : arg4,
            sqrt_price  : arg5,
            liquidity   : arg6,
            source      : arg7,
            vault       : arg8,
            payload     : arg9,
        }
    }

    public fun owner(arg0: &Receipt) : address {
        arg0.owner
    }

    public fun payload(arg0: &Receipt) : vector<u8> {
        arg0.payload
    }

    public fun pool_id(arg0: &Receipt) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &Receipt) : 0x2::object::ID {
        arg0.position_id
    }

    public fun source(arg0: &Receipt) : u64 {
        arg0.source
    }

    public fun sqrt_price(arg0: &Receipt) : u128 {
        arg0.sqrt_price
    }

    public fun vault(arg0: &Receipt) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        arg0.vault
    }

    // decompiled from Move bytecode v6
}

