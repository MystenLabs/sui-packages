module 0x7f34a1ef1f2edb30f2653e3da4544d33248b0c064186bf07cfcb7f5859e7c8e6::slot {
    struct Slot has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
    }

    struct SlotCreated has copy, drop, store {
        slot: address,
        owner: address,
    }

    struct Deposit has copy, drop, store {
        slot: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        slot: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Slot) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0;
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balances, v0));
        };
        v1
    }

    public(friend) fun add_to_balance<T0>(arg0: &mut Slot, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Slot{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            balances : 0x2::bag::new(arg0),
        };
        let v1 = SlotCreated{
            slot  : 0x2::object::id_address<Slot>(&v0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<SlotCreated>(v1);
        0x2::transfer::public_share_object<Slot>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (v0 == 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>())) {
            add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        } else {
            add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(0x2::coin::value<T0>(&arg1), arg1, 0, arg2, arg3)));
        };
        let v1 = Deposit{
            slot   : 0x2::object::id_address<Slot>(arg0),
            token  : v0,
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun get_owner(arg0: &Slot) : address {
        arg0.owner
    }

    public(friend) fun take_from_balance<T0>(arg0: &mut Slot, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2) {
            assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        };
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg3)
    }

    public entry fun withdraw<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_balance<T0>(arg0, arg1, true, arg3);
        if (0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>())) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, 0x2::sui::SUI>(0x2::coin::value<T0>(&v0), v0, 0, arg2, arg3), 0x2::tx_context::sender(arg3));
        };
        let v1 = Withdraw{
            slot   : 0x2::object::id_address<Slot>(arg0),
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<Withdraw>(v1);
    }

    // decompiled from Move bytecode v6
}

