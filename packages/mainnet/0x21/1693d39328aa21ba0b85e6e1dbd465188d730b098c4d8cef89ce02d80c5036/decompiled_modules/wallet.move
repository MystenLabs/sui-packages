module 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::wallet {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun balance_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_vault<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::zero_balance<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun delete_vault<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: Vault<T0>) {
        let Vault {
            id      : v0,
            balance : v1,
        } = arg1;
        let v2 = v1;
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts::must_amount_equals(0x2::balance::value<T0>(&v2), 0);
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::destroy_zero_balance<T0>(v2);
        0x2::object::delete(v0);
    }

    public fun deposit_balance_by_admin<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::balance::Balance<T0>) {
        destroy_or_deposit_balance<T0>(arg1, arg2);
    }

    public fun deposit_by_admin<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>) {
        destroy_or_deposit<T0>(arg1, arg2);
    }

    public fun destroy_or_deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, 0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::coin_to_balance<T0>(arg1));
        };
    }

    public fun destroy_or_deposit_balance<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::destroy_zero_balance<T0>(arg1);
        } else {
            0x2::balance::join<T0>(&mut arg0.balance, arg1);
        };
    }

    public fun split_vault_balance<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts::must_amount(arg2);
        0x2::balance::split<T0>(&mut arg1.balance, arg2)
    }

    public fun withdraw<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::asserts::must_amount(arg2);
        0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::tools::transfer_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3, arg4);
    }

    public fun withdraw_to_admin<T0>(arg0: &0x211693d39328aa21ba0b85e6e1dbd465188d730b098c4d8cef89ce02d80c5036::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        withdraw<T0>(arg0, arg1, arg2, v0, arg3);
    }

    // decompiled from Move bytecode v7
}

