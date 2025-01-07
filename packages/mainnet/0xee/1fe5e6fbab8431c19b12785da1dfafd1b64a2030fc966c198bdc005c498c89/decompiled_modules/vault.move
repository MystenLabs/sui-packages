module 0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        vaults: 0x2::bag::Bag,
    }

    struct R has copy, drop {
        a: u64,
        b: u64,
    }

    public fun borrow<T0>(arg0: &0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::Permits, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::valid(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3)
    }

    public fun borrow_vec<T0>(arg0: &0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::Permits, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, borrow<T0>(arg0, arg1, arg2, arg3));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::bag::new(arg0),
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

    public fun pay<T0>(arg0: &0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::Permits, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::valid(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0), 0x2::coin::into_balance<T0>(arg2));
        assert!(v1 > arg3 && v1 - arg3 >= arg4, 909);
        let v2 = R{
            a : arg3,
            b : v1,
        };
        0x2::event::emit<R>(v2);
    }

    public entry fun take<T0>(arg0: &0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control::Master, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

