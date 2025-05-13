module 0x249a048a22710085f4c29f99e7acf23697ec152f8265ed8dcaad909827a361fd::mm_vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::table::Table<address, 0x2::bag::Bag>,
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
    }

    struct UserBalance has drop, store {
        amount: u64,
    }

    struct BalanceEvent has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        deposit: bool,
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id              : 0x2::object::new(arg0),
            balances        : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
            balance_manager : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = BalanceEvent{
            vault   : 0x2::object::id<Vault>(arg0),
            user    : v0,
            asset   : v2,
            amount  : v1,
            deposit : true,
        };
        0x2::event::emit<BalanceEvent>(v3);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.balances, v0)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.balances, v0, 0x2::bag::new(arg2));
        };
        let v4 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.balances, v0);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v4, v2)) {
            let v5 = UserBalance{amount: 0};
            0x2::bag::add<0x1::type_name::TypeName, UserBalance>(v4, v2, v5);
        };
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, UserBalance>(v4, v2);
        v6.amount = v6.amount + v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.balance_manager, arg1, arg2);
    }

    public fun get_balance<T0>(arg0: &Vault, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.balances, v0)) {
            return 0
        };
        let v2 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.balances, v0);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v2, v1)) {
            return 0
        };
        0x2::bag::borrow<0x1::type_name::TypeName, UserBalance>(v2, v1).amount
    }

    public fun get_balance_manager(arg0: &mut Vault) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &mut arg0.balance_manager
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.balances, v0), 0);
        let v2 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.balances, v0);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(v2, v1), 0);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, UserBalance>(v2, v1);
        assert!(arg1 <= v3.amount, 0);
        v3.amount = v3.amount - arg1;
        let v4 = BalanceEvent{
            vault   : 0x2::object::id<Vault>(arg0),
            user    : v0,
            asset   : v1,
            amount  : arg1,
            deposit : false,
        };
        0x2::event::emit<BalanceEvent>(v4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.balance_manager, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

