module 0x862dae1a6b81f7f7b119ce1fd41ac0ca29dfb2fc56b346de38236b32a7d0759b::treasury_system {
    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct TokenTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct DepositEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Treasury {
        Treasury{
            id       : 0x2::object::new(arg0),
            admin    : 0x2::tx_context::sender(arg0),
            balances : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        }
    }

    public entry fun create_and_share_treasury(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Treasury>(new(arg0));
    }

    public entry fun deposit_token<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x1::type_name::get<T0>();
        0x2::object::id<Treasury>(arg0);
        0x2::object::id_from_address(@0x0);
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, v1)) {
            let v2 = TokenTreasury<T0>{
                id              : 0x2::object::new(arg2),
                balance         : 0x2::coin::into_balance<T0>(arg1),
                total_deposited : v0,
                total_withdrawn : 0,
            };
            0x2::transfer::share_object<TokenTreasury<T0>>(v2);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, v1, v0);
        } else {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.balances, v1);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, v1, *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, v1) + v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.admin);
        };
        let v3 = DepositEvent{
            token_type : v1,
            amount     : v0,
            depositor  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun emergency_withdraw<T0>(arg0: &Treasury, arg1: &mut TokenTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_for_swap<T0>(arg1, arg2, arg3), arg0.admin);
    }

    public fun get_token_balance<T0>(arg0: &TokenTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_treasury_stats<T0>(arg0: &TokenTreasury<T0>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.total_deposited, arg0.total_withdrawn)
    }

    public fun withdraw_for_swap<T0>(arg0: &mut TokenTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 1);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        let v0 = WithdrawEvent{
            token_type : 0x1::type_name::get<T0>(),
            amount     : arg1,
            recipient  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

