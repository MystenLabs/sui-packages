module 0xa8a4f9c4f6c65bb20088221b22d5d661a6ff6b8565bda2f494a73275612f8be9::distributor {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        claimed_users: 0x2::table::Table<address, u64>,
        claimed_users_vec: vector<address>,
        balance: 0x2::balance::Balance<T0>,
        claim_amount: u64,
    }

    fun add_vec<T0>(arg0: &mut Vault<T0>, arg1: address) {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"num")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"num", 0);
        };
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"num");
        *v0 = *v0 + 1;
        let v1 = b"claimed_users_vec";
        0x1::vector::push_back<u8>(&mut v1, ((*v0 / 5000) as u8));
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
            0x2::dynamic_field::add<vector<u8>, vector<address>>(&mut arg0.id, v1, vector[]);
        };
        0x1::vector::push_back<address>(0x2::dynamic_field::borrow_mut<vector<u8>, vector<address>>(&mut arg0.id, v1), arg1);
    }

    public entry fun claim_vault<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed_users, v0), 0);
        0x2::table::add<address, u64>(&mut arg0.claimed_users, v0, arg0.claim_amount);
        add_vec<T0>(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg0.claim_amount), arg1), v0);
    }

    public entry fun create_vault<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg1),
            claimed_users     : 0x2::table::new<address, u64>(arg1),
            claimed_users_vec : vector[],
            balance           : 0x2::balance::zero<T0>(),
            claim_amount      : arg0,
        };
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    public fun deposit_to_vault<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun refresh_vault<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf89bf436d166578e84fcd4e726ae206ff24851f1647b0a264114180cc2591914, 0);
        while (arg1 > 0) {
            0x2::table::remove<address, u64>(&mut arg0.claimed_users, 0x1::vector::pop_back<address>(&mut arg0.claimed_users_vec));
            arg1 = arg1 - 1;
        };
    }

    public entry fun refresh_vault2<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xf89bf436d166578e84fcd4e726ae206ff24851f1647b0a264114180cc2591914, 0);
        let v0 = b"claimed_users_vec";
        0x1::vector::push_back<u8>(&mut v0, arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, vector<address>>(&mut arg0.id, v0);
        if (arg2 > 0x1::vector::length<address>(v1)) {
            arg2 = 0x1::vector::length<address>(v1);
        };
        while (arg2 > 0) {
            0x2::table::remove<address, u64>(&mut arg0.claimed_users, 0x1::vector::pop_back<address>(v1));
            arg2 = arg2 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

