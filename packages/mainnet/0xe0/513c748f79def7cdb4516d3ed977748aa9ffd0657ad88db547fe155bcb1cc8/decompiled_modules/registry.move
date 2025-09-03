module 0xe0513c748f79def7cdb4516d3ed977748aa9ffd0657ad88db547fe155bcb1cc8::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        allowed_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_price_delta_pips: u64,
        max_output_delta_pips: u64,
        fee_configs: vector<FeeConfig>,
        fee_balances: 0x2::bag::Bag,
        fee_wallet: address,
    }

    struct FeeConfig has drop, store {
        rebalance_fee_pips: u64,
        compound_fee_pips: u64,
        zap_fee_pips: u64,
        max_pool_fee_pips: u64,
    }

    struct FeeCollected has copy, drop {
        pool_id: 0x2::object::ID,
        fee_token: 0x1::type_name::TypeName,
        fee_source: u64,
        fee_amount: u64,
    }

    fun type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun claim_fees<T0>(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = type_name<T0>();
        let v1 = if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balances, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public fun collect_fees<T0>(arg0: &mut Registry, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        let v0 = type_name<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balances, v0, arg2);
        };
        let v1 = FeeCollected{
            pool_id    : arg1,
            fee_token  : v0,
            fee_source : 0,
            fee_amount : arg3,
        };
        0x2::event::emit<FeeCollected>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id                    : 0x2::object::new(arg0),
            version               : 1,
            allowed_witnesses     : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            max_price_delta_pips  : 25000,
            max_output_delta_pips : 500,
            fee_configs           : 0x1::vector::empty<FeeConfig>(),
            fee_balances          : 0x2::bag::new(arg0),
            fee_wallet            : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    // decompiled from Move bytecode v6
}

