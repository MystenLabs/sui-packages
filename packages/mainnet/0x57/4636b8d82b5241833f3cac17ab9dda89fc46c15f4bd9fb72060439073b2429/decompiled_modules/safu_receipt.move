module 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::safu_receipt {
    struct SafuReceipt<phantom T0> {
        bc_id: 0x2::object::ID,
        target: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        sui_balance_val: u64,
        meme_balance_val: u64,
        target_pool_id: 0x2::object::ID,
    }

    public(friend) fun burn<T0>(arg0: SafuReceipt<T0>) : (0x2::object::ID, u64, u64, u64, 0x2::object::ID) {
        let SafuReceipt {
            bc_id            : v0,
            target           : v1,
            sui_balance      : v2,
            meme_balance     : v3,
            sui_balance_val  : v4,
            meme_balance_val : v5,
            target_pool_id   : v6,
        } = arg0;
        let v7 = v3;
        let v8 = v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&v8) == 0, 3);
        assert!(0x2::balance::value<T0>(&v7) == 0, 3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        0x2::balance::destroy_zero<T0>(v7);
        (v0, v1, v4, v5, v6)
    }

    public(friend) fun extract_assets<T0>(arg0: &mut SafuReceipt<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>) {
        (0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)), 0x2::balance::split<T0>(&mut arg0.meme_balance, 0x2::balance::value<T0>(&arg0.meme_balance)))
    }

    public(friend) fun mint<T0>(arg0: u64, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::object::ID) : SafuReceipt<T0> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg2) > 0, 1);
        SafuReceipt<T0>{
            bc_id            : arg3,
            target           : arg0,
            sui_balance      : arg1,
            meme_balance     : arg2,
            sui_balance_val  : 0x2::balance::value<0x2::sui::SUI>(&arg1),
            meme_balance_val : 0x2::balance::value<T0>(&arg2),
            target_pool_id   : 0x2::object::id_from_address(@0x0),
        }
    }

    public(friend) fun target<T0>(arg0: &SafuReceipt<T0>) : u64 {
        arg0.target
    }

    // decompiled from Move bytecode v6
}

