module 0x4ca1f8e56068def32c608269a260cb0f9658a9fda5b75d95923d290ec8891c8::generic_sale {
    struct ClaimVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::coin::Coin<T0>,
        balances: 0x2::table::Table<address, u64>,
        total_allocated: u64,
        max_supply: u64,
        price_per_token: u64,
        sui_receiver: address,
        admin: address,
        claimable_enabled: bool,
    }

    struct ConfigUpdated has copy, drop {
        claimable_enabled: bool,
        admin: address,
    }

    struct TokensPurchased has copy, drop {
        buyer: address,
        amount: u64,
        price_paid: u64,
        referrer_paid: u64,
        referrer: address,
    }

    struct TokensClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    public entry fun buy_tokens<T0>(arg0: &mut ClaimVault<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 >= 1000, 6);
        assert!(arg4 <= 500, 8);
        assert!(arg0.total_allocated + arg2 <= arg0.max_supply, 7);
        let v1 = arg0.price_per_token * arg2 / 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 5);
        let v2 = 0;
        let v3 = if (arg4 > 0 && arg3 != @0x0) {
            if (arg3 != v0) {
                let v4 = v1 * arg4 / 10000;
                v2 = v4;
                if (v4 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg5), arg3);
                };
                v1 - v4
            } else {
                v1
            }
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg5), arg0.sui_receiver);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (0x2::table::contains<address, u64>(&arg0.balances, v0)) {
            0x2::table::remove<address, u64>(&mut arg0.balances, v0);
            0x2::table::add<address, u64>(&mut arg0.balances, v0, *0x2::table::borrow<address, u64>(&arg0.balances, v0) + arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.balances, v0, arg2);
        };
        arg0.total_allocated = arg0.total_allocated + arg2;
        let v5 = TokensPurchased{
            buyer         : v0,
            amount        : arg2,
            price_paid    : v1,
            referrer_paid : v2,
            referrer      : arg3,
        };
        0x2::event::emit<TokensPurchased>(v5);
    }

    public entry fun claim<T0>(arg0: &mut ClaimVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.claimable_enabled, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, v0), 4);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.balances, v0);
        assert!(v1 > 0, 4);
        let v2 = TokensClaimed{
            claimer : v0,
            amount  : v1,
        };
        0x2::event::emit<TokensClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool, v1, arg1), v0);
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ClaimVault<T0>{
            id                : 0x2::object::new(arg2),
            pool              : arg0,
            balances          : 0x2::table::new<address, u64>(arg2),
            total_allocated   : 0,
            max_supply        : 0x2::coin::value<T0>(&arg0),
            price_per_token   : arg1,
            sui_receiver      : @0xc81648a63cf64ddf2385a22479d65613d5ed7f26145ec786f25dd3250de32610,
            admin             : v0,
            claimable_enabled : false,
        };
        let v2 = ConfigUpdated{
            claimable_enabled : false,
            admin             : v0,
        };
        0x2::event::emit<ConfigUpdated>(v2);
        0x2::transfer::public_share_object<ClaimVault<T0>>(v1);
    }

    public entry fun enable_claiming<T0>(arg0: &mut ClaimVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        assert!(!arg0.claimable_enabled, 2);
        arg0.claimable_enabled = true;
        let v0 = ConfigUpdated{
            claimable_enabled : true,
            admin             : arg0.admin,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun get_admin<T0>(arg0: &ClaimVault<T0>) : address {
        arg0.admin
    }

    public fun get_price_per_token<T0>(arg0: &ClaimVault<T0>) : u64 {
        arg0.price_per_token
    }

    public fun get_sale_progress<T0>(arg0: &ClaimVault<T0>) : (u64, u64) {
        (arg0.total_allocated, arg0.max_supply - arg0.total_allocated)
    }

    public fun get_user_balance<T0>(arg0: &ClaimVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.balances, arg1)
        } else {
            0
        }
    }

    public fun is_claimable_enabled<T0>(arg0: &ClaimVault<T0>) : bool {
        arg0.claimable_enabled
    }

    public fun lamports_to_tokens(arg0: u64) : (u64, u64) {
        (arg0 / 1000000000, arg0 % 1000000000)
    }

    public entry fun withdraw_unsold<T0>(arg0: &mut ClaimVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.sui_receiver, 1);
        let v1 = arg0.max_supply - arg0.total_allocated;
        if (v1 > 0) {
            arg0.total_allocated = arg0.max_supply;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool, v1, arg1), v0);
        };
    }

    // decompiled from Move bytecode v6
}

