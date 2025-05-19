module 0xcbd0e73eff7dad949890594d6df5e34909becd0b50e0a638cbad3d4430e349fb::generic_sale {
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
    }

    struct TokensClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    public entry fun buy_tokens<T0>(arg0: &mut ClaimVault<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 > 0, 6);
        let v1 = arg2 * 1000000000;
        assert!(arg0.total_allocated + v1 <= arg0.max_supply, 7);
        let v2 = arg0.price_per_token * arg2;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v3 >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg3), arg0.sui_receiver);
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
        arg0.total_allocated = arg0.total_allocated + v1;
        let v4 = TokensPurchased{
            buyer      : v0,
            amount     : arg2,
            price_paid : v3,
        };
        0x2::event::emit<TokensPurchased>(v4);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.pool, v1 * 1000000000, arg1), v0);
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = ClaimVault<T0>{
            id                : 0x2::object::new(arg3),
            pool              : arg0,
            balances          : 0x2::table::new<address, u64>(arg3),
            total_allocated   : 0,
            max_supply        : arg1 * 1000000000,
            price_per_token   : arg2,
            sui_receiver      : @0xe444cd1d6c27719fcddfff3ca68127568393d604f9666b4674ef3ccc5ffc0b8c,
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

