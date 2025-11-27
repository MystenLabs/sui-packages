module 0xfbffcc854d3f510e82deecf0d891ed30d85e0f31c4a9173826d3b422c72539fd::reward_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExchangeRate has drop, store {
        loyalty_amount: u64,
        reward_amount: u64,
    }

    struct PoolRefreshedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RewardRedeemedEvent has copy, drop {
        token_name: 0x1::string::String,
        amount: u64,
        user_address: address,
    }

    struct RewardProgram has drop {
        dummy_field: bool,
    }

    struct RewardPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
        exchange_rate: ExchangeRate,
        admin_cap_id: 0x2::object::ID,
    }

    entry fun new<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = RewardPool<T0, T1>{
            id            : 0x2::object::new(arg3),
            balance       : 0x2::coin::into_balance<T1>(arg0),
            exchange_rate : new_safe_exchange_rate(arg1, arg2),
            admin_cap_id  : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::share_object<RewardPool<T0, T1>>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun claim<T0, T1>(arg0: &mut RewardPool<T0, T1>, arg1: 0x2::token::Token<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = exchange_amount(&arg0.exchange_rate, 0x2::token::value<T0>(&arg1));
        let v1 = if (0x1::option::is_some<u64>(&arg3)) {
            0x1::option::destroy_some<u64>(arg3)
        } else {
            0x1::option::destroy_none<u64>(arg3);
            1
        };
        assert!(v1 <= v0, 2);
        assert!(v0 <= 0x2::balance::value<T1>(&arg0.balance), 0);
        let v2 = 0x2::token::spend<T0>(arg1, arg4);
        let v3 = RewardProgram{dummy_field: false};
        0x2::token::add_approval<T0, RewardProgram>(v3, &mut v2, arg4);
        let (v4, v5, v6, _) = 0x2::token::confirm_request_mut<T0>(arg2, v2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, v0), arg4), 0x2::tx_context::sender(arg4));
        let v8 = RewardRedeemedEvent{
            token_name   : v4,
            amount       : v5,
            user_address : v6,
        };
        0x2::event::emit<RewardRedeemedEvent>(v8);
    }

    public fun exchange_amount(arg0: &ExchangeRate, arg1: u64) : u64 {
        let v0 = 0x1::u128::try_as_u64((arg0.reward_amount as u128) * (arg1 as u128) / (arg0.loyalty_amount as u128));
        0x1::option::extract<u64>(&mut v0)
    }

    public fun new_safe_exchange_rate(arg0: u64, arg1: u64) : ExchangeRate {
        assert!(arg0 != 0, 2);
        assert!(arg1 != 0, 2);
        ExchangeRate{
            loyalty_amount : arg0,
            reward_amount  : arg1,
        }
    }

    entry fun refresh<T0, T1>(arg0: &mut RewardPool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(arg1));
        let v0 = PoolRefreshedEvent{
            pool_id : 0x2::object::id<RewardPool<T0, T1>>(arg0),
            amount  : 0x2::balance::value<T1>(&arg0.balance),
        };
        0x2::event::emit<PoolRefreshedEvent>(v0);
    }

    public fun revoke<T0, T1>(arg0: RewardPool<T0, T1>, arg1: &mut AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 1);
        let RewardPool {
            id            : v0,
            balance       : v1,
            exchange_rate : _,
            admin_cap_id  : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun update_exchange_rate<T0, T1>(arg0: &mut RewardPool<T0, T1>, arg1: &mut AdminCap, arg2: u64, arg3: u64) {
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 1);
        arg0.exchange_rate = new_safe_exchange_rate(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

