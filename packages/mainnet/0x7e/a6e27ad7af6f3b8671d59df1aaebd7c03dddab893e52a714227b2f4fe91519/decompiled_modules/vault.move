module 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct Collect has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        source: u64,
    }

    struct Withdraw has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public(friend) fun collect<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        let v1 = Collect{
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
            source    : arg2,
        };
        0x2::event::emit<Collect>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun withdraw<T0>(arg0: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::admin::AdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>());
        let v1 = 0x1::u64::min(arg2, 0x2::balance::value<T0>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, v1, arg4), arg3);
        let v2 = Withdraw{
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v1,
            recipient : arg3,
        };
        0x2::event::emit<Withdraw>(v2);
    }

    // decompiled from Move bytecode v6
}

