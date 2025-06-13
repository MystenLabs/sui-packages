module 0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        total_fee_a: u64,
        total_fee_b: u64,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        total_contribution: u64,
        claimed: vector<address>,
    }

    struct LpVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        position_bag: 0x2::bag::Bag,
        curator: address,
        fee_vault: Vault<T0, T1>,
    }

    struct FeeCollected<phantom T0, phantom T1> has copy, drop {
        lp_vault_address: address,
        fee_a: u64,
        fee_b: u64,
        collector: address,
        timestamp: u64,
    }

    struct FeeClaimed<phantom T0, phantom T1> has copy, drop {
        vault_address: address,
        user: address,
        amount_a: u64,
        amount_b: u64,
        user_amount: u64,
        total_contribution: u64,
    }

    public fun id_to_address(arg0: &0x2::object::ID) : address {
        0x2::object::id_to_address(arg0)
    }

    public fun claim<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.claimed)) {
            if (*0x1::vector::borrow<address>(&arg0.claimed, v0) == arg1) {
                return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::none<0x2::coin::Coin<T1>>())
            };
            v0 = v0 + 1;
        };
        if (arg2 == 0 || arg0.total_contribution == 0) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::none<0x2::coin::Coin<T1>>())
        };
        let v1 = arg0.total_fee_a * arg2 / arg0.total_contribution;
        let v2 = arg0.total_fee_b * arg2 / arg0.total_contribution;
        0x1::vector::push_back<address>(&mut arg0.claimed, arg1);
        let v3 = if (v1 > 0) {
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_a, v1, arg3))
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v4 = if (v2 > 0) {
            0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_b, v2, arg3))
        } else {
            0x1::option::none<0x2::coin::Coin<T1>>()
        };
        0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::emit_fee_claimed<T0, T1>(0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::get_id(&arg0.id), arg1, v1, v2, arg2, arg0.total_contribution);
        (v3, v4)
    }

    public fun collect_lp_fee<T0, T1>(arg0: &mut LpVault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.curator == v0, 1);
        let v1 = 0x2::bag::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_bag, b"position");
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v1, true);
        let v4 = v3;
        let v5 = v2;
        0x2::bag::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position_bag, b"position", v1);
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        0x2::balance::join<T0>(&mut arg0.fee_vault.balance_a, v5);
        0x2::balance::join<T1>(&mut arg0.fee_vault.balance_b, v4);
        arg0.fee_vault.total_fee_a = arg0.fee_vault.total_fee_a + v6;
        arg0.fee_vault.total_fee_b = arg0.fee_vault.total_fee_b + v7;
        0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::emit_fee_collected<T0, T1>(0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::get_id(&arg0.id), v6, v7, v0, arg3);
    }

    public fun get_fee_vault<T0, T1>(arg0: &LpVault<T0, T1>) : &Vault<T0, T1> {
        &arg0.fee_vault
    }

    public fun id<T0, T1>(arg0: &LpVault<T0, T1>) : 0x2::object::ID {
        0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::get_id(&arg0.id)
    }

    public fun new_lp_vault<T0, T1>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LpVault<T0, T1> {
        let v0 = 0x2::bag::new(arg2);
        0x2::bag::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0, b"position", arg0);
        let v1 = 0x2::coin::zero<T0>(arg2);
        let v2 = 0x2::coin::zero<T1>(arg2);
        let v3 = new_vault<T0, T1>(0, v1, v2, 0, arg2);
        LpVault<T0, T1>{
            id           : 0x2::object::new(arg2),
            position_bag : v0,
            curator      : arg1,
            fee_vault    : v3,
        }
    }

    public fun new_vault<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        Vault<T0, T1>{
            id                 : 0x2::object::new(arg4),
            epoch              : arg0,
            total_fee_a        : 0x2::coin::value<T0>(&arg1),
            total_fee_b        : 0x2::coin::value<T1>(&arg2),
            balance_a          : 0x2::coin::into_balance<T0>(arg1),
            balance_b          : 0x2::coin::into_balance<T1>(arg2),
            total_contribution : arg3,
            claimed            : 0x1::vector::empty<address>(),
        }
    }

    public fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        0x5d5eaf503ce0045258e9b5c43897252e05ba1ed9bc96a348adf9f75f507edd8b::events::get_id(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

