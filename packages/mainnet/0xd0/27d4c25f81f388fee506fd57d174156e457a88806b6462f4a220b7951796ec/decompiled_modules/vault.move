module 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        vaults: 0x2::bag::Bag,
        mate_fee_rate: u64,
    }

    struct R has copy, drop {
        a: u64,
        b: u64,
    }

    struct FlashLoan {
        type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoan) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 4);
        let v2 = FlashLoan{
            type   : 0x1::type_name::get<T0>(),
            amount : arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), v2)
    }

    public(friend) fun back_<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.vaults, 0x1::type_name::get<T0>()), arg1);
    }

    public fun borrow_vec<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, FlashLoan) {
        let (v0, v1) = borrow<T0>(arg0, arg1, arg2, arg3);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, v0);
        (v2, v1)
    }

    public entry fun delete_dynamic_field<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: &mut Vault, arg2: &mut 0x2::tx_context::TxContext) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0)) {
            0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            vaults        : 0x2::bag::new(arg0),
            mate_fee_rate : 10000,
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public entry fun into<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vaults, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vaults, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun into_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v0, 0x2::coin::zero<T0>(arg3));
        };
        0x2::coin::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v0), 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun pay<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Permits, arg1: FlashLoan, arg2: &mut Vault, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::valid(arg0, 0x2::tx_context::sender(arg6));
        let FlashLoan {
            type   : v0,
            amount : v1,
        } = arg1;
        let v2 = 0x1::type_name::get<T0>();
        assert!(v0 == v2, 1);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg2.vaults, v2), 3);
        let v3 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.vaults, v2);
        let v4 = 0x2::coin::value<T0>(&arg3);
        if (0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::is_mate(arg0, 0x2::tx_context::sender(arg6))) {
            assert!(v4 >= v1, 10);
        };
        assert!(v4 > arg4 && v4 - arg4 >= arg5, 909);
        let v5 = 0x2::tx_context::sender(arg6);
        let (v6, arg3) = if (0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::is_mate(arg0, v5)) {
            (0x2::coin::split<T0>(&mut arg3, (10000 - arg2.mate_fee_rate) * (v4 - arg4) / 10000, arg6), arg3)
        } else {
            (0x2::coin::zero<T0>(arg6), arg3)
        };
        0x2::balance::join<T0>(v3, 0x2::coin::into_balance<T0>(arg3));
        0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::help::transfer<T0>(v6, v5);
        let v7 = R{
            a : arg4,
            b : v4,
        };
        0x2::event::emit<R>(v7);
    }

    public entry fun take<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Master, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun take_coin<T0>(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Master, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg1.vaults, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun update_fee_rate(arg0: &0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control::Master, arg1: &mut Vault, arg2: u64) {
        arg1.mate_fee_rate = arg2;
    }

    public(friend) fun use_<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.vaults, v0);
        assert!(0x2::coin::value<T0>(v1) >= arg1, 4);
        0x2::coin::split<T0>(v1, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

