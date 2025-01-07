module 0x84b42f6c43e1598182246c0cab4c9f39dae1b350df41f6b289e3d98dc1771fce::getter {
    struct OracleInfo has copy, drop {
        oracle_id: u8,
        price: u256,
        decimals: u8,
        valid: bool,
    }

    struct UserStateInfo has copy, drop {
        asset_id: u8,
        borrow_balance: u256,
        supply_balance: u256,
    }

    public fun get_oracle_info(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: vector<u8>) : vector<OracleInfo> {
        let v0 = 0x1::vector::empty<OracleInfo>();
        let v1 = 0x1::vector::length<u8>(&arg2);
        while (v1 > 0) {
            let v2 = 0x1::vector::borrow<u8>(&arg2, v1 - 1);
            let (v3, v4, v5) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::get_token_price(arg0, arg1, *v2);
            let v6 = OracleInfo{
                oracle_id : *v2,
                price     : v4,
                decimals  : v5,
                valid     : v3,
            };
            0x1::vector::push_back<OracleInfo>(&mut v0, v6);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_user_state(arg0: &mut 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::Storage, arg1: address) : vector<UserStateInfo> {
        let v0 = 0x1::vector::empty<UserStateInfo>();
        let v1 = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::get_reserves_count(arg0);
        while (v1 > 0) {
            let (v2, v3) = 0x7093782c6c2b5f928340fc5b600a2be6afe2b8107a0a0dbde5d971cccadab2c5::storage::get_user_balance(arg0, v1 - 1, arg1);
            let v4 = UserStateInfo{
                asset_id       : v1 - 1,
                borrow_balance : v3,
                supply_balance : v2,
            };
            0x1::vector::push_back<UserStateInfo>(&mut v0, v4);
            v1 = v1 - 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

