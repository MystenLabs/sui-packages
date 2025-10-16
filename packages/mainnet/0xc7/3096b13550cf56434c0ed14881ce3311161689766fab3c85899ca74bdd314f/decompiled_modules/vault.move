module 0xc73096b13550cf56434c0ed14881ce3311161689766fab3c85899ca74bdd314f::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct Deposit has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        source: u64,
    }

    struct Withdraw has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0xc73096b13550cf56434c0ed14881ce3311161689766fab3c85899ca74bdd314f::math::pct_bps(0x2::coin::value<T0>(arg1), arg3);
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::split<T0>(arg1, v1, arg4));
        let v2 = Deposit{
            coin_type : v0,
            amount    : v1,
            source    : arg2,
        };
        0x2::event::emit<Deposit>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &0xc73096b13550cf56434c0ed14881ce3311161689766fab3c85899ca74bdd314f::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        let v2 = Withdraw{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&v1),
            recipient : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Withdraw>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

