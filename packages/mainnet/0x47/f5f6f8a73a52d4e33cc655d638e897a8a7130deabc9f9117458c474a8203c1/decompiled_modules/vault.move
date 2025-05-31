module 0x47f5f6f8a73a52d4e33cc655d638e897a8a7130deabc9f9117458c474a8203c1::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        deposits: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        depositor: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdrawer: address,
        amount: u64,
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id       : 0x2::object::new(arg0),
            deposits : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg0),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v1 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 2);
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.deposits, v0)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.deposits, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.deposits, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v2 = DepositEvent{
            depositor : v0,
            amount    : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public fun get_balance<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.deposits, arg1)) {
            0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.deposits, arg1))
        } else {
            0
        }
    }

    public fun get_my_balance<T0>(arg0: &Vault<T0>, arg1: &0x2::tx_context::TxContext) : u64 {
        get_balance<T0>(arg0, 0x2::tx_context::sender(arg1))
    }

    public fun has_deposits<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.deposits, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.deposits, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.deposits, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 0);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.deposits, v0));
        };
        let v2 = WithdrawEvent{
            withdrawer : v0,
            amount     : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.deposits, v0), 1);
        let v1 = 0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.deposits, v0);
        let v2 = WithdrawEvent{
            withdrawer : v0,
            amount     : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

