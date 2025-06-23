module 0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::slot {
    struct Slot has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
    }

    struct SlotInitialized has copy, drop, store {
        owner: address,
        slot: address,
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
        let v1 = SlotInitialized{
            owner : 0x2::tx_context::sender(arg0),
            slot  : 0x2::object::id_address<Slot>(&v0),
        };
        0x2::event::emit<SlotInitialized>(v1);
        0x2::transfer::public_share_object<Slot>(v0);
    }

    public fun owner(arg0: &Slot) : address {
        arg0.owner
    }

    public(friend) fun take_from_balance<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public(friend) fun take_from_balance_with_permission<T0>(arg0: &mut Slot, arg1: u64, arg2: &0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::Platform, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!0x49bc12b822acf2e0aa0b67133ad1c11710aa2aca19ecc5dbf4fcfdeae45f0466::platform::has_permission(arg2, owner(arg0), arg3, arg4)) {
            assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        };
        take_from_balance<T0>(arg0, arg1, arg4)
    }

    public(friend) fun take_from_balance_with_sender<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        take_from_balance<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

