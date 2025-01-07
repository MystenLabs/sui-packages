module 0xf40c246f8db0a5b43c5fd3428075b2a26f846b82bd8dabfbcc589d642c591a82::m0 {
    struct OP has copy, drop {
        d0: u8,
        d1: bool,
        d2: u256,
        d3: u8,
        d4: u256,
        d5: u256,
        d6: u256,
        d7: u256,
    }

    struct UI has copy, drop {
        d0: u8,
        d1: u256,
        d2: u256,
    }

    public fun g0(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : vector<OP> {
        let v0 = 0x1::vector::empty<OP>();
        let v1 = 0;
        while (v1 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg2)) {
            let (v2, v3, v4) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, v1);
            let (v5, v6, v7) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg2, v1);
            let v8 = OP{
                d0 : v1,
                d1 : v2,
                d2 : v3,
                d3 : v4,
                d4 : v5,
                d5 : v6,
                d6 : v7,
                d7 : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg2, v1),
            };
            0x1::vector::push_back<OP>(&mut v0, v8);
            v1 = v1 + 1;
        };
        v0
    }

    public fun g1(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address) : vector<UI> {
        let v0 = 0x1::vector::empty<UI>();
        let v1 = 0;
        while (v1 < 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg0)) {
            let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v1, arg1);
            let (v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, v1);
            let v6 = UI{
                d0 : v1,
                d1 : 0xf40c246f8db0a5b43c5fd3428075b2a26f846b82bd8dabfbcc589d642c591a82::ray_math::ray_mul(v3, v5),
                d2 : 0xf40c246f8db0a5b43c5fd3428075b2a26f846b82bd8dabfbcc589d642c591a82::ray_math::ray_mul(v2, v4),
            };
            0x1::vector::push_back<UI>(&mut v0, v6);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

