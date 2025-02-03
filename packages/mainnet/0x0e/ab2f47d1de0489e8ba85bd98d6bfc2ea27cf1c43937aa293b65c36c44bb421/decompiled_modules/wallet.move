module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::wallet {
    struct Wallet has store {
        main: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::Pocket,
        fee: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::Pocket,
        reward: 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::Pocket,
    }

    struct WalletBalance has copy, drop, store {
        main: vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>,
        fee: vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>,
        reward: vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>,
    }

    public fun destroy_empty(arg0: Wallet) {
        let Wallet {
            main   : v0,
            fee    : v1,
            reward : v2,
        } = arg0;
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::destroy_empty(v0);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::destroy_empty(v1);
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::destroy_empty(v2);
    }

    public(friend) fun claim<T0>(arg0: &mut Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::claim<T0>(&mut arg0.main, arg1, arg2);
    }

    public(friend) fun deposit<T0>(arg0: &mut Wallet, arg1: 0x2::balance::Balance<T0>) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::deposit<T0>(&mut arg0.main, arg1);
    }

    public fun get_all_balances(arg0: &Wallet) : vector<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance> {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.main), 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.fee), 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.reward)))
    }

    public fun get_balance(arg0: &Wallet) : WalletBalance {
        WalletBalance{
            main   : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.main),
            fee    : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.fee),
            reward : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_all_balances(&arg0.reward),
        }
    }

    public fun get_pool_amounts<T0, T1>(arg0: &Wallet) : (u64, u64) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_pool_amounts<T0, T1>(&arg0.main)
    }

    public fun get_pool_balance<T0, T1>(arg0: &Wallet) : (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_pool_balance<T0, T1>(&arg0.main)
    }

    public fun is_empty(arg0: &Wallet) : bool {
        if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::is_empty(&arg0.main)) {
            if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::is_empty(&arg0.fee)) {
                0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::is_empty(&arg0.reward)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun join_balances(arg0: WalletBalance, arg1: WalletBalance) : WalletBalance {
        WalletBalance{
            main   : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(arg0.main, arg1.main),
            fee    : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(arg0.fee, arg1.fee),
            reward : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::join_balances(arg0.reward, arg1.reward),
        }
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Wallet {
        Wallet{
            main   : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::new(arg0),
            fee    : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::new(arg0),
            reward : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::new(arg0),
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Wallet, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::withdraw<T0>(&mut arg0.main, arg1)
    }

    public(friend) fun apply_fee<T0>(arg0: &mut Wallet) {
        if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::contains<T0>(&arg0.fee)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::deposit<T0>(&mut arg0.main, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::withdraw_all<T0>(&mut arg0.fee));
        };
    }

    public(friend) fun apply_reward<T0>(arg0: &mut Wallet) {
        if (0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::contains<T0>(&arg0.reward)) {
            0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::deposit<T0>(&mut arg0.main, 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::withdraw_all<T0>(&mut arg0.reward));
        };
    }

    public(friend) fun claim_fee<T0>(arg0: &mut Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::claim<T0>(&mut arg0.fee, arg1, arg2);
    }

    public(friend) fun claim_reward<T0>(arg0: &mut Wallet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::claim<T0>(&mut arg0.reward, arg1, arg2);
    }

    public(friend) fun deposit_fee<T0>(arg0: &mut Wallet, arg1: 0x2::balance::Balance<T0>) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::deposit<T0>(&mut arg0.fee, arg1);
    }

    public(friend) fun deposit_reward<T0>(arg0: &mut Wallet, arg1: 0x2::balance::Balance<T0>) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::deposit<T0>(&mut arg0.reward, arg1);
    }

    public fun get_coin_amount<T0>(arg0: &Wallet) : u64 {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_amount<T0>(&arg0.main)
    }

    public fun get_coin_balance<T0>(arg0: &Wallet) : 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::get_balance<T0>(&arg0.main)
    }

    public(friend) fun withdraw_fee<T0>(arg0: &mut Wallet, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::withdraw<T0>(&mut arg0.fee, arg1)
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut Wallet, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::withdraw<T0>(&mut arg0.reward, arg1)
    }

    public fun zero_balance() : WalletBalance {
        WalletBalance{
            main   : 0x1::vector::empty<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>(),
            fee    : 0x1::vector::empty<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>(),
            reward : 0x1::vector::empty<0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket::CoinBalance>(),
        }
    }

    // decompiled from Move bytecode v6
}

