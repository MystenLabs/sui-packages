module 0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::vault {
    struct WithdrawFeeEvent has copy, drop {
        coin: 0x1::ascii::String,
        amount: u64,
    }

    struct CollectFeeEvent has copy, drop {
        coin: 0x1::ascii::String,
        amount: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &Vault) : u64 {
        let v0 = coin_key<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            0
        } else {
            0x2::coin::value<T0>(0x2::dynamic_object_field::borrow<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.id, v0))
        }
    }

    public fun coin_key<T0>() : 0x1::ascii::String {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::type_name::borrow_string(&v0)
    }

    public(friend) fun collect_fee<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = coin_key<T0>();
        if (!0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0)) {
            0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        } else {
            0x2::coin::join<T0>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        };
        let v1 = CollectFeeEvent{
            coin   : v0,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CollectFeeEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun withdraw_fee<T0>(arg0: &0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::Role, arg1: &mut Vault, arg2: &0x2::tx_context::TxContext) {
        0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::only_collector(arg0, arg2);
        let v0 = coin_key<T0>();
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg1.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0xc357c3985e8fb875d6b37141497af660779aa1bab0ec489b2213efd74067d1fa::role::get_collector(arg0));
        let v2 = WithdrawFeeEvent{
            coin   : v0,
            amount : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<WithdrawFeeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

