module 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h7f984 {
    fun h110dc(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun h32780<T0>(arg0: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::authority::ACCOUNT, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>, arg2: &mut 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg3: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock) : bool {
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg2);
        if (!0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::exists_position<T0>(arg0, v0)) {
            return true
        };
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::update_funding<T0>(arg0, arg4, arg6);
        0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::settle_position_funding<T0>(arg0, arg5, v0, arg6);
        let (_, v2, v3, v4, _) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h552f1(arg3);
        let v6 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::scaling_factor(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_params<T0>(arg0));
        let (v7, v8) = hed69a<T0>(arg0, v0, v6);
        if (v7 || v8 < v3) {
            let v9 = if (v7) {
                v2 + v8
            } else {
                v2 - v8
            };
            let v10 = 0x1::u64::min(v9, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::collateral_balance<T0>(arg2));
            if (v10 > 0) {
                0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::allocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, arg1, arg2, v10);
            };
            let (v11, v12) = hed69a<T0>(arg0, v0, v6);
            return !v11 && v12 >= v3
        };
        if (v8 > v4) {
            let v13 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::market_params<T0>(arg0);
            let v14 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::position<T0>(arg0, v0);
            let v15 = 0x1::u64::min(v8 - v2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral(v14, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::collateral_oracle_price(v13, arg5, arg6), 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::mark_price<T0>(arg0, arg4, arg6), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v14, 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::margin_ratio_initial(v13)), 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::market::collateral_haircut(v13)), v6));
            if (v15 > 0) {
                0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::deallocate_collateral<T0, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>(arg0, arg1, arg2, arg4, arg5, v15, arg6);
            };
        };
        true
    }

    public(friend) fun h635a1<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg3: u64, arg4: u256, arg5: u256, arg6: u256) : (u256, u256) {
        let (v0, _, _, _, _) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h552f1(arg2);
        let v5 = (v0 as u256) * arg4;
        let (v6, v7, v8, v9) = hddecf<T0>(arg0, arg1);
        let v10 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v7, arg3);
        let (v11, v12) = if (v6) {
            (h110dc(v5, v10), v5 + v10)
        } else {
            (v5 + v10, h110dc(v5, v10))
        };
        (h110dc(v11, h110dc(0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v8, arg3), arg5)), h110dc(v12, h110dc(0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v9, arg3), arg6)))
    }

    public(friend) fun h8adf6<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>, arg2: &0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::H032e6, arg3: u64, arg4: u256) : (u256, u256) {
        let (v0, _, _, _, _) = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h95cce::h552f1(arg2);
        let v5 = (v0 as u256) * arg4;
        let (v6, v7, v8, v9) = hddecf<T0>(arg0, arg1);
        let v10 = 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v7, arg3);
        let (v11, v12) = if (v6) {
            (h110dc(v5, v10), v5 + v10)
        } else {
            (v5 + v10, h110dc(v5, v10))
        };
        (h110dc(v11, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v8, arg3)), h110dc(v12, 0x9b087a96812bf84eded875f64b77a4b240759d76185c074ce09c781449415a50::h5a57f::h9aa0e(v9, arg3)))
    }

    public(friend) fun hb2e0b<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::mark_price<T0>(arg0, arg1, arg2), 1000000000);
        assert!(v0 > 0, 527);
        v0
    }

    fun hddecf<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::Account<T0>) : (bool, u64, u64, u64) {
        let v0 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::account::account_id<T0>(arg1);
        if (!0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::exists_position<T0>(arg0, v0)) {
            return (true, 0, 0, 0)
        };
        let v1 = 0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::position<T0>(arg0, v0);
        let (v2, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v1);
        let (v4, v5) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v1);
        (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v2), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v2), 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v5, 1000000000), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v4, 1000000000))
    }

    fun hed69a<T0>(arg0: &0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: u256) : (bool, u64) {
        let v0 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(0xd6f84f3a6a0bcee7288f72af297a87ab6f5d1a60a5d467d8c44ef55d915d3fb3::clearing_house::position<T0>(arg0, arg1));
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0), arg2))
    }

    // decompiled from Move bytecode v7
}

