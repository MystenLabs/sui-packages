module 0x6fcc5671a287f45d16aeb215aea32f1507de38a163b4021781779a3339033aa2::my_first_contract {
    struct StateStorage has key {
        id: 0x2::object::UID,
        state: u8,
        owner: address,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        state_id: address,
    }

    struct StateChanged has copy, drop {
        state_id: address,
        old_state: u8,
        new_state: u8,
    }

    fun assert_owner(arg0: &StateStorage, arg1: &OwnerCap) {
        assert!(arg1.state_id == 0x2::object::uid_to_address(&arg0.id), 0);
    }

    public entry fun create_state_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StateStorage{
            id    : 0x2::object::new(arg0),
            state : 0,
            owner : 0x2::tx_context::sender(arg0),
        };
        let v1 = OwnerCap{
            id       : 0x2::object::new(arg0),
            state_id : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::transfer::share_object<StateStorage>(v0);
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun funny_function<T0>(arg0: &StateStorage, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: address, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg0.state < 4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        } else if (arg0.state >= 4) {
            is_correct_percent(arg4);
            if (arg4 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
            } else if (arg4 == 100) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, (((0x2::coin::value<T0>(&arg1) as u128) * (arg4 as u128) / 100) as u64), arg5), arg3);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    fun is_correct_percent(arg0: u8) {
        assert!(arg0 >= 0 && arg0 <= 100, 1);
    }

    public entry fun set_state(arg0: &mut StateStorage, arg1: &OwnerCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.state = arg2;
        let v0 = StateChanged{
            state_id  : 0x2::object::uid_to_address(&arg0.id),
            old_state : arg0.state,
            new_state : arg2,
        };
        0x2::event::emit<StateChanged>(v0);
    }

    public entry fun split_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        is_correct_percent(arg3);
        if (arg3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        } else if (arg3 == 100) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, (((0x2::coin::value<T0>(&arg0) as u128) * (arg3 as u128) / 100) as u64), arg4), arg2);
        };
    }

    // decompiled from Move bytecode v7
}

