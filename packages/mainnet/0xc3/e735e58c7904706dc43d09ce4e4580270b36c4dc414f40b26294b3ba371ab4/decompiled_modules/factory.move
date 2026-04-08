module 0xc3e735e58c7904706dc43d09ce4e4580270b36c4dc414f40b26294b3ba371ab4::factory {
    struct AirdropPool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_received: u64,
    }

    struct Bin has copy, drop, store {
        price: u64,
        token_reserves: u64,
        sui_reserves: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        token_vault: 0x2::balance::Balance<T0>,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        bins: vector<Bin>,
        active_bin_index: u64,
        total_supply: u64,
        total_burned: u64,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        burn_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        shared_blob_id: 0x2::object::ID,
        volume: u64,
        trade_count: u64,
        active: bool,
        created_epoch: u64,
    }

    struct TokenLaunched has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        total_supply: u64,
        num_bins: u64,
        lowest_price: u64,
        highest_price: u64,
        shared_blob_id: 0x2::object::ID,
        treasury_cap_frozen: bool,
        metadata_frozen: bool,
    }

    struct Swap has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        price: u64,
        fee_total: u64,
        fee_platform: u64,
        fee_treasury: u64,
        fee_creator: u64,
        fee_burn: u64,
        fee_airdrop: u64,
    }

    struct TokensBurned has copy, drop {
        pool_id: 0x2::object::ID,
        sui_spent: u64,
        tokens_burned: u64,
        total_burned_lifetime: u64,
    }

    public fun airdrop_balance(arg0: &AirdropPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun airdrop_total_received(arg0: &AirdropPool) : u64 {
        arg0.total_received
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: &mut AirdropPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.active, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = v0 * 10 / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v4 = v1 * 3000 / 10000;
        let v5 = v1 * 3000 / 10000;
        let v6 = v1 * 1000 / 10000;
        let v7 = v1 * 2000 / 10000;
        let v8 = v1 - v4 - v5 - v6 - v7;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v4), arg3), @0x6915bc38bccd03a6295e9737143e4ef3318bcdc75be80a3114f317633bdd3304);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v5), arg3), @0x79df07beab543f716c6be24fa6326e28fa11bd103ff655c3a4d17a6f84b86b4e);
        };
        if (v6 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v6));
        };
        if (v7 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v7));
        };
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v8));
            arg1.total_received = arg1.total_received + v8;
        };
        let v9 = v2;
        let v10 = 0;
        let v11 = 0x1::vector::length<Bin>(&arg0.bins);
        let v12 = arg0.active_bin_index;
        while (v9 > 0 && v12 < v11) {
            let v13 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, v12);
            if (v13.token_reserves == 0) {
                v12 = v12 + 1;
                continue
            };
            let v14 = v9 * 1000000000 / v13.price;
            if (v14 >= v13.token_reserves) {
                let v15 = v13.token_reserves * v13.price / 1000000000;
                let v16 = if (v15 > v9) {
                    v9
                } else {
                    v15
                };
                v10 = v10 + v13.token_reserves;
                v13.sui_reserves = v13.sui_reserves + v16;
                v13.token_reserves = 0;
                v9 = v9 - v16;
                v12 = v12 + 1;
                continue
            };
            v10 = v10 + v14;
            v13.token_reserves = v13.token_reserves - v14;
            v13.sui_reserves = v13.sui_reserves + v9;
            v9 = 0;
        };
        assert!(v10 > 0, 3);
        let v17 = if (v12 < v11) {
            v12
        } else {
            v11 - 1
        };
        arg0.active_bin_index = v17;
        let v18 = v2 - v9;
        arg0.volume = arg0.volume + v18;
        arg0.trade_count = arg0.trade_count + 1;
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v9), arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, v3);
        let v19 = Swap{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            trader       : 0x2::tx_context::sender(arg3),
            is_buy       : true,
            sui_amount   : v18,
            token_amount : v10,
            price        : get_active_price<T0>(arg0),
            fee_total    : v1,
            fee_platform : v4,
            fee_treasury : v5,
            fee_creator  : v6,
            fee_burn     : v7,
            fee_airdrop  : v8,
        };
        0x2::event::emit<Swap>(v19);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_vault, v10), arg3)
    }

    public fun claim_creator_fees<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1)
    }

    public fun execute_burn<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.burn_pool);
        if (v0 == 0) {
            return
        };
        let v1 = v0;
        let v2 = 0;
        let v3 = 0x1::vector::length<Bin>(&arg0.bins);
        let v4 = arg0.active_bin_index;
        while (v1 > 0 && v4 < v3) {
            let v5 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, v4);
            if (v5.token_reserves == 0) {
                v4 = v4 + 1;
                continue
            };
            let v6 = v1 * 1000000000 / v5.price;
            if (v6 >= v5.token_reserves) {
                let v7 = v5.token_reserves * v5.price / 1000000000;
                let v8 = if (v7 > v1) {
                    v1
                } else {
                    v7
                };
                v2 = v2 + v5.token_reserves;
                v5.sui_reserves = v5.sui_reserves + v8;
                v5.token_reserves = 0;
                v1 = v1 - v8;
                v4 = v4 + 1;
                continue
            };
            v2 = v2 + v6;
            v5.token_reserves = v5.token_reserves - v6;
            v5.sui_reserves = v5.sui_reserves + v1;
            v1 = 0;
        };
        let v9 = v0 - v1;
        if (v9 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.burn_pool, v9));
        };
        if (v2 > 0) {
            0x2::transfer::public_freeze_object<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_vault, v2), arg1));
            arg0.total_burned = arg0.total_burned + v2;
            let v10 = if (v4 < v3) {
                v4
            } else {
                v3 - 1
            };
            arg0.active_bin_index = v10;
            let v11 = TokensBurned{
                pool_id               : 0x2::object::id<Pool<T0>>(arg0),
                sui_spent             : v9,
                tokens_burned         : v2,
                total_burned_lifetime : arg0.total_burned,
            };
            0x2::event::emit<TokensBurned>(v11);
        };
    }

    public fun get_active_price<T0>(arg0: &Pool<T0>) : u64 {
        if (arg0.active_bin_index < 0x1::vector::length<Bin>(&arg0.bins)) {
            0x1::vector::borrow<Bin>(&arg0.bins, arg0.active_bin_index).price
        } else {
            0
        }
    }

    public fun get_bin<T0>(arg0: &Pool<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Bin>(&arg0.bins, arg1);
        (v0.price, v0.token_reserves, v0.sui_reserves)
    }

    public fun get_burn_pool<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.burn_pool)
    }

    public fun get_creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun get_creator_fees<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun get_num_bins<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<Bin>(&arg0.bins)
    }

    public fun get_shared_blob_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.shared_blob_id
    }

    public fun get_total_burned<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_burned
    }

    public fun get_total_supply<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_supply
    }

    public fun get_trade_count<T0>(arg0: &Pool<T0>) : u64 {
        arg0.trade_count
    }

    public fun get_volume<T0>(arg0: &Pool<T0>) : u64 {
        arg0.volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropPool{
            id             : 0x2::object::new(arg0),
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_received : 0,
        };
        0x2::transfer::public_share_object<AirdropPool>(v0);
    }

    public fun is_active<T0>(arg0: &Pool<T0>) : bool {
        arg0.active
    }

    public fun launch<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(arg3 > 0, 0);
        assert!(arg6 > 0 && arg6 <= 100, 2);
        assert!(arg4 > 0, 0);
        assert!(arg5 > 0, 0);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(arg2, arg7);
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = arg3 / arg6;
        let v2 = 0x1::vector::empty<Bin>();
        let v3 = arg4;
        let v4 = 0;
        while (v4 < arg6) {
            let v5 = if (v4 == 0) {
                v1 + arg3 - v1 * arg6
            } else {
                v1
            };
            let v6 = Bin{
                price          : v3,
                token_reserves : v5,
                sui_reserves   : 0,
            };
            0x1::vector::push_back<Bin>(&mut v2, v6);
            v3 = v3 + arg5;
            v4 = v4 + 1;
        };
        let v7 = Pool<T0>{
            id               : 0x2::object::new(arg7),
            creator          : 0x2::tx_context::sender(arg7),
            token_vault      : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg0, arg3, arg7)),
            sui_vault        : 0x2::balance::zero<0x2::sui::SUI>(),
            bins             : v2,
            active_bin_index : 0,
            total_supply     : arg3,
            total_burned     : 0,
            creator_fees     : 0x2::balance::zero<0x2::sui::SUI>(),
            burn_pool        : 0x2::balance::zero<0x2::sui::SUI>(),
            shared_blob_id   : v0,
            volume           : 0,
            trade_count      : 0,
            active           : true,
            created_epoch    : 0x2::tx_context::epoch(arg7),
        };
        let v8 = TokenLaunched{
            pool_id             : 0x2::object::id<Pool<T0>>(&v7),
            creator             : 0x2::tx_context::sender(arg7),
            total_supply        : arg3,
            num_bins            : arg6,
            lowest_price        : arg4,
            highest_price       : v3 - arg5,
            shared_blob_id      : v0,
            treasury_cap_frozen : true,
            metadata_frozen     : true,
        };
        0x2::event::emit<TokenLaunched>(v8);
        v7
    }

    public fun sell<T0>(arg0: &mut Pool<T0>, arg1: &mut AirdropPool, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.active, 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        0x2::balance::join<T0>(&mut arg0.token_vault, 0x2::coin::into_balance<T0>(arg2));
        let v1 = v0;
        let v2 = 0;
        let v3 = arg0.active_bin_index;
        let v4 = false;
        while (v1 > 0 && !v4) {
            let v5 = 0x1::vector::borrow_mut<Bin>(&mut arg0.bins, v3);
            if (v5.sui_reserves == 0) {
                if (v3 == 0) {
                    v4 = true;
                    continue
                };
                v3 = v3 - 1;
                continue
            };
            let v6 = v5.sui_reserves * 1000000000 / v5.price;
            if (v1 >= v6) {
                v2 = v2 + v5.sui_reserves;
                v5.token_reserves = v5.token_reserves + v6;
                v5.sui_reserves = 0;
                v1 = v1 - v6;
                if (v3 == 0) {
                    v4 = true;
                    continue
                };
                v3 = v3 - 1;
                continue
            };
            let v7 = v1 * v5.price / 1000000000;
            v2 = v2 + v7;
            v5.token_reserves = v5.token_reserves + v1;
            v5.sui_reserves = v5.sui_reserves - v7;
            v1 = 0;
        };
        assert!(v2 > 0, 3);
        arg0.active_bin_index = v3;
        let v8 = v2 * 10 / 10000;
        let v9 = v2 - v8;
        let v10 = v8 * 3000 / 10000;
        let v11 = v8 * 3000 / 10000;
        let v12 = v8 * 1000 / 10000;
        let v13 = v8 * 2000 / 10000;
        let v14 = v8 - v10 - v11 - v12 - v13;
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v10), arg3), @0x6915bc38bccd03a6295e9737143e4ef3318bcdc75be80a3114f317633bdd3304);
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v11), arg3), @0x79df07beab543f716c6be24fa6326e28fa11bd103ff655c3a4d17a6f84b86b4e);
        };
        if (v12 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v12));
        };
        if (v13 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.burn_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v13));
        };
        if (v14 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v14));
            arg1.total_received = arg1.total_received + v14;
        };
        arg0.volume = arg0.volume + v2;
        arg0.trade_count = arg0.trade_count + 1;
        let v15 = Swap{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            trader       : 0x2::tx_context::sender(arg3),
            is_buy       : false,
            sui_amount   : v9,
            token_amount : v0,
            price        : get_active_price<T0>(arg0),
            fee_total    : v8,
            fee_platform : v10,
            fee_treasury : v11,
            fee_creator  : v12,
            fee_burn     : v13,
            fee_airdrop  : v14,
        };
        0x2::event::emit<Swap>(v15);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v9), arg3)
    }

    public fun withdraw_airdrop(arg0: &mut AirdropPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

