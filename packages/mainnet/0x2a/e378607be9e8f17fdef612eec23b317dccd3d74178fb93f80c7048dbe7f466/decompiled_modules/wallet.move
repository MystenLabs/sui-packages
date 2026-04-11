module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_is_admin(0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_sender(arg0));
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::zero_balance<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit_balance_by_admin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_is_admin(0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_sender(arg2));
        destroy_or_deposit_balance<T0>(arg0, arg1);
    }

    public fun deposit_by_admin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_is_admin(0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_sender(arg2));
        destroy_or_deposit<T0>(arg0, arg1);
    }

    public fun destroy_or_deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(arg1));
        };
    }

    public fun destroy_or_deposit_balance<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero_balance<T0>(arg1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, arg1);
        };
    }

    public fun split_vault_balance<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount(arg1);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_is_admin(0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::get_sender(arg3));
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts::must_amount(0x2::balance::value<T0>(&arg0.balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
    }

    public fun withdraw_to_admin<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw<T0>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::admin::get_address(), arg2);
    }

    // decompiled from Move bytecode v7
}

