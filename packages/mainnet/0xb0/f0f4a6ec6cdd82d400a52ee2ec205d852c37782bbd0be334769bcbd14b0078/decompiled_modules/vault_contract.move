module 0xb0f0f4a6ec6cdd82d400a52ee2ec205d852c37782bbd0be334769bcbd14b0078::vault_contract {
    struct RewardCompounded has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct PositionRebalancedAll has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct PositionRebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        old_lower_tick: u32,
        old_upper_tick: u32,
        new_lower_tick: u32,
        new_upper_tick: u32,
        liquidity_amount: u128,
        timestamp: u64,
    }

    struct VaultShare has drop, store {
        id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct DepositCertificate has drop, store {
        id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct Funding has drop, store {
        investor: address,
        amount: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        total_assets: u64,
        total_shares: u64,
        fundings: vector<Funding>,
        bluefin_pool_id: 0x1::option::Option<0x2::object::ID>,
        admin: address,
    }

    struct BluefinPosition has drop, store {
        id: 0x2::object::ID,
    }

    fun assert_admin(arg0: &Vault, arg1: address) {
        assert!(arg0.admin == arg1, 9001);
    }

    public entry fun close_bluefin_position<T0>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<0x2::sui::SUI, T0>(arg2, arg3, arg0, arg1, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun collect_bluefin_rewards<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<0x2::sui::SUI, T0, T1>(arg2, arg3, arg0, arg1, arg4);
    }

    public entry fun compound_rewards<T0, T1>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &0x2::clock::Clock, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg5));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::collect_reward<0x2::sui::SUI, T0, T1>(arg3, arg4, arg1, arg2, arg5);
        let v0 = RewardCompounded{
            vault_id  : 0x2::object::id<Vault>(arg0),
            amount    : 1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardCompounded>(v0);
    }

    public entry fun create_lst_usdc_position<T0, T1>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, arg1, arg2, arg3, arg11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::provide_liquidity<T0, T1>(arg10, arg4, arg1, &mut v0, arg5, arg6, arg7, arg8, arg9, arg11);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, arg1);
        arg0.total_assets = arg0.total_assets + v0;
        arg0.total_shares = arg0.total_shares + v0;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Funding>(&arg0.fundings)) {
            let v4 = 0x1::vector::borrow_mut<Funding>(&mut arg0.fundings, v3);
            if (v4.investor == v1) {
                v4.amount = v4.amount + v0;
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        if (!v2) {
            let v5 = Funding{
                investor : v1,
                amount   : v0,
            };
            0x1::vector::push_back<Funding>(&mut arg0.fundings, v5);
        };
        0xb0f0f4a6ec6cdd82d400a52ee2ec205d852c37782bbd0be334769bcbd14b0078::vault_nft::mint_nft(arg2, arg3, arg4, v1, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id              : 0x2::object::new(arg0),
            coin            : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg0),
            total_assets    : 0,
            total_shares    : 0,
            fundings        : 0x1::vector::empty<Funding>(),
            bluefin_pool_id : 0x1::option::none<0x2::object::ID>(),
            admin           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public entry fun open_bluefin_position<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: u32, arg3: u32, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<0x2::sui::SUI, T0>(arg4, arg1, arg2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun provide_bluefin_liquidity<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg10: &mut 0x2::tx_context::TxContext) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::provide_liquidity<0x2::sui::SUI, T0>(arg8, arg9, arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg3, arg10), arg4, arg5, arg6, arg7, arg10);
    }

    public entry fun rebalance_all_positions<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg3: vector<u32>, arg4: vector<u32>, arg5: vector<u64>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg8));
        assert!(0x1::vector::length<u32>(&arg3) == 0x1::vector::length<u32>(&arg4), 1);
        assert!(0x1::vector::length<u32>(&arg4) == 0x1::vector::length<u64>(&arg5), 2);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg5)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg5, v1);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 4);
        while (!0x1::vector::is_empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2)) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<0x2::sui::SUI, T0>(arg7, arg6, arg1, 0x1::vector::pop_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg2), 0x2::tx_context::sender(arg8), arg8);
        };
        0x1::vector::destroy_empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u32>(&arg3)) {
            let v3 = *0x1::vector::borrow<u32>(&arg3, v2);
            let v4 = *0x1::vector::borrow<u32>(&arg4, v2);
            0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<0x2::sui::SUI, T0>(arg6, arg1, v3, v4, arg8), 0x2::tx_context::sender(arg8));
            let v5 = PositionRebalanced{
                vault_id         : 0x2::object::id<Vault>(arg0),
                old_lower_tick   : 0,
                old_upper_tick   : 0,
                new_lower_tick   : v3,
                new_upper_tick   : v4,
                liquidity_amount : (*0x1::vector::borrow<u64>(&arg5, v2) as u128),
                timestamp        : 0x2::clock::timestamp_ms(arg7),
            };
            0x2::event::emit<PositionRebalanced>(v5);
            v2 = v2 + 1;
        };
        let v6 = PositionRebalancedAll{
            vault_id  : 0x2::object::id<Vault>(arg0),
            timestamp : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PositionRebalancedAll>(v6);
    }

    public entry fun rebalance_position<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg7));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::close_position<0x2::sui::SUI, T0>(arg5, arg6, arg1, arg2, 0x2::tx_context::sender(arg7), arg7);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<0x2::sui::SUI, T0>(arg6, arg1, arg3, arg4, arg7), 0x2::tx_context::sender(arg7));
        let v0 = PositionRebalanced{
            vault_id         : 0x2::object::id<Vault>(arg0),
            old_lower_tick   : 0,
            old_upper_tick   : 0,
            new_lower_tick   : arg3,
            new_upper_tick   : arg4,
            liquidity_amount : 0,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PositionRebalanced>(v0);
    }

    public entry fun swap_bluefin<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: u64, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x2::tx_context::TxContext) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::gateway::swap_assets<0x2::sui::SUI, T0>(arg5, arg6, arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg2, arg7), 0x2::coin::zero<T0>(arg7), true, true, arg2, arg3, arg4, arg7);
    }

    public entry fun withdraw(arg0: &mut Vault, arg1: u64, arg2: 0xb0f0f4a6ec6cdd82d400a52ee2ec205d852c37782bbd0be334769bcbd14b0078::vault_nft::VaultNFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<Funding>(&arg0.fundings)) {
            let v3 = 0x1::vector::borrow_mut<Funding>(&mut arg0.fundings, v1);
            if (v3.investor == v0) {
                assert!(v3.amount >= arg1, 0);
                v3.amount = v3.amount - arg1;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 1);
        assert!(arg0.total_assets >= arg1, 2);
        arg0.total_assets = arg0.total_assets - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg1, arg3), v0);
        0x2::transfer::public_freeze_object<0xb0f0f4a6ec6cdd82d400a52ee2ec205d852c37782bbd0be334769bcbd14b0078::vault_nft::VaultNFT>(arg2);
    }

    // decompiled from Move bytecode v6
}

