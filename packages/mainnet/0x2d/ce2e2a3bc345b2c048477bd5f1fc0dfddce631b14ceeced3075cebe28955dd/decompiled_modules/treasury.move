module 0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::treasury {
    struct TreasurySupplyEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        value: u64,
    }

    struct TreasuryClaimEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        value: u64,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
    }

    public fun balance_of<T0>(arg0: &Treasury) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun claim<T0>(arg0: &mut Treasury, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = TreasuryClaimEvent{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            value     : arg2,
        };
        0x2::event::emit<TreasuryClaimEvent>(v0);
        let v1 = BalanceKey<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Treasury>(v0);
    }

    public fun supply_treasury<T0>(arg0: &mut Treasury, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        let v1 = TreasurySupplyEvent{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            value     : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<TreasurySupplyEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

