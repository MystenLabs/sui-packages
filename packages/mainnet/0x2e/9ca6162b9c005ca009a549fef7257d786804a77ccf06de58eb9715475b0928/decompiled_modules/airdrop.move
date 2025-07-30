module 0x2e9ca6162b9c005ca009a549fef7257d786804a77ccf06de58eb9715475b0928::airdrop {
    struct AirDrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        claims: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        airdrop: 0x2::object::ID,
    }

    public fun add_claims<T0>(arg0: &mut AirDrop<T0>, arg1: &mut AdminCap<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: 0x2::coin::Coin<T0>) {
        let v0 = 0;
        let v1 = &arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            let v3 = 0x1::vector::borrow<u64>(v1, v2);
            assert!(*v3 > 0, 13906834371911876607);
            v0 = v0 + *v3;
            v2 = v2 + 1;
        };
        assert!(0x2::coin::value<T0>(&arg4) >= v0, 0);
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834397681680383);
        0x1::vector::reverse<address>(&mut arg2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg2)) {
            0x2::table::add<address, u64>(&mut arg0.claims, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg4));
    }

    entry fun claim<T0>(arg0: &mut AirDrop<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<address, u64>(&mut arg0.claims, 0x2::tx_context::sender(arg1));
        assert!(v0 > 0, 13906834505055862783);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun get_claim<T0>(arg0: &AirDrop<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.claims, arg1)
    }

    public fun new_airdrop<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        let v0 = AirDrop<T0>{
            id      : 0x2::object::new(arg0),
            claims  : 0x2::table::new<address, u64>(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = AdminCap<T0>{
            id      : 0x2::object::new(arg0),
            airdrop : 0x2::object::id<AirDrop<T0>>(&v0),
        };
        0x2::transfer::public_share_object<AirDrop<T0>>(v0);
        v1
    }

    public fun remove_claims<T0>(arg0: &mut AirDrop<T0>, arg1: &mut AdminCap<T0>, arg2: vector<address>, arg3: vector<u64>) {
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834449221287935);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::table::add<address, u64>(&mut arg0.claims, v1, 0x2::table::remove<address, u64>(&mut arg0.claims, v1) + 0x1::vector::pop_back<u64>(&mut arg3));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    public fun withdraw_balance<T0>(arg0: &mut AirDrop<T0>, arg1: &mut AdminCap<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance))
    }

    // decompiled from Move bytecode v6
}

