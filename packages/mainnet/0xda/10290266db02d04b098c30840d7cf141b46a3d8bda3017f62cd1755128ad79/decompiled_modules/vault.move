module 0xda10290266db02d04b098c30840d7cf141b46a3d8bda3017f62cd1755128ad79::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        members: 0x2::vec_set::VecSet<address>,
        balances: 0x2::bag::Bag,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_member(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 1);
        if (!0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.members, arg2);
        };
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        let v2 = Vault{
            id       : 0x2::object::new(arg0),
            members  : v1,
            balances : 0x2::bag::new(arg0),
        };
        let v3 = AdminCap{
            id       : 0x2::object::new(arg0),
            vault_id : 0x2::object::id<Vault>(&v2),
        };
        0x2::transfer::share_object<Vault>(v2);
        0x2::transfer::transfer<AdminCap>(v3, v0);
    }

    public fun is_member(arg0: &Vault, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.members, &arg1)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 1);
        if (0x2::vec_set::contains<address>(&arg1.members, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.members, &arg2);
        };
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 0);
        let v1 = BalanceKey<T0>{dummy_field: false};
        0x2::coin::take<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

