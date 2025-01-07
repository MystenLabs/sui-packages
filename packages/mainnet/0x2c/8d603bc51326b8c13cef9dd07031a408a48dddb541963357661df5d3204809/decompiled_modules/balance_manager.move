module 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager {
    struct BalanceManager has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
        allow_listed: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct BalanceEvent has copy, drop {
        balance_manager_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        deposit: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TradeCap has store, key {
        id: 0x2::object::UID,
        balance_manager_id: 0x2::object::ID,
    }

    struct TradeProof has drop {
        balance_manager_id: 0x2::object::ID,
        trader: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : BalanceManager {
        BalanceManager{
            id           : 0x2::object::new(arg0),
            owner        : 0x2::tx_context::sender(arg0),
            balances     : 0x2::bag::new(arg0),
            allow_listed : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun balance<T0>(arg0: &BalanceManager) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        }
    }

    public(friend) fun delete(arg0: BalanceManager) {
        let BalanceManager {
            id           : v0,
            owner        : _,
            balances     : v2,
            allow_listed : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::bag::destroy_empty(v2);
    }

    public fun id(arg0: &BalanceManager) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun deposit<T0>(arg0: &mut BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceEvent{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            asset              : 0x1::type_name::get<T0>(),
            amount             : 0x2::coin::value<T0>(&arg1),
            deposit            : true,
        };
        0x2::event::emit<BalanceEvent>(v0);
        let v1 = generate_proof_as_owner(arg0, arg2);
        deposit_with_proof<T0>(arg0, &v1, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun deposit_with_proof<T0>(arg0: &mut BalanceManager, arg1: &TradeProof, arg2: 0x2::balance::Balance<T0>) {
        validate_proof(arg0, arg1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg2);
        };
    }

    public fun generate_proof_as_owner(arg0: &mut BalanceManager, arg1: &0x2::tx_context::TxContext) : TradeProof {
        validate_owner(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg1),
        }
    }

    public fun generate_proof_as_trader(arg0: &mut BalanceManager, arg1: &TradeCap, arg2: &0x2::tx_context::TxContext) : TradeProof {
        validate_trader(arg0, arg1);
        TradeProof{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            trader             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun mint_trade_cap(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : TradeCap {
        validate_owner(arg0, arg1);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.allow_listed) < 1000, 4);
        let v0 = 0x2::object::new(arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allow_listed, 0x2::object::uid_to_inner(&v0));
        TradeCap{
            id                 : v0,
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
        }
    }

    public fun owner(arg0: &BalanceManager) : address {
        arg0.owner
    }

    public fun revoke_trade_cap(arg0: &mut BalanceManager, arg1: &0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        validate_owner(arg0, arg2);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, arg1), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allow_listed, arg1);
    }

    public(friend) fun trader(arg0: &TradeProof) : address {
        arg0.trader
    }

    fun validate_owner(arg0: &BalanceManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == owner(arg0), 0);
    }

    public fun validate_proof(arg0: &BalanceManager, arg1: &TradeProof) {
        assert!(0x2::object::id<BalanceManager>(arg0) == arg1.balance_manager_id, 2);
    }

    fun validate_trader(arg0: &BalanceManager, arg1: &TradeCap) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allow_listed, 0x2::object::borrow_id<TradeCap>(arg1)), 1);
    }

    public fun withdraw<T0>(arg0: &mut BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_proof_as_owner(arg0, arg2);
        let v1 = withdraw_with_proof<T0>(arg0, &v0, arg1, false);
        let v2 = 0x2::coin::from_balance<T0>(v1, arg2);
        let v3 = BalanceEvent{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            asset              : 0x1::type_name::get<T0>(),
            amount             : 0x2::coin::value<T0>(&v2),
            deposit            : false,
        };
        0x2::event::emit<BalanceEvent>(v3);
        v2
    }

    public fun withdraw_all<T0>(arg0: &mut BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_proof_as_owner(arg0, arg1);
        let v1 = withdraw_with_proof<T0>(arg0, &v0, 0, true);
        let v2 = 0x2::coin::from_balance<T0>(v1, arg1);
        let v3 = BalanceEvent{
            balance_manager_id : 0x2::object::id<BalanceManager>(arg0),
            asset              : 0x1::type_name::get<T0>(),
            amount             : 0x2::coin::value<T0>(&v2),
            deposit            : false,
        };
        0x2::event::emit<BalanceEvent>(v3);
        v2
    }

    public(friend) fun withdraw_with_proof<T0>(arg0: &mut BalanceManager, arg1: &TradeProof, arg2: u64, arg3: bool) : 0x2::balance::Balance<T0> {
        validate_proof(arg0, arg1);
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (arg3) {
            if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
                0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
            } else {
                0x2::balance::zero<T0>()
            }
        } else {
            assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 3);
            let v2 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
            let v3 = 0x2::balance::value<T0>(v2);
            assert!(v3 >= arg2, 3);
            if (arg2 == v3) {
                0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
            } else {
                0x2::balance::split<T0>(v2, arg2)
            }
        }
    }

    // decompiled from Move bytecode v6
}

