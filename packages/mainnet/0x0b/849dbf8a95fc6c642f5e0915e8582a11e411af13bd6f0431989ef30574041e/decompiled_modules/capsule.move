module 0xb849dbf8a95fc6c642f5e0915e8582a11e411af13bd6f0431989ef30574041e::capsule {
    struct CapsuleManager<phantom T0: drop> has key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        amounts: Amounts,
    }

    struct AdminCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        manager_id: 0x2::object::ID,
    }

    struct Amounts has copy, drop, store {
        common: u64,
        uncommon: u64,
        rare: u64,
    }

    public fun new<T0: drop>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (CapsuleManager<T0>, AdminCap<T0>) {
        let v0 = 0x2::object::new(arg3);
        let v1 = Amounts{
            common   : arg0,
            uncommon : arg1,
            rare     : arg2,
        };
        let v2 = CapsuleManager<T0>{
            id       : 0x2::object::new(arg3),
            admin_id : 0x2::object::uid_to_inner(&v0),
            balance  : 0x2::balance::zero<T0>(),
            amounts  : v1,
        };
        let v3 = AdminCap<T0>{
            id         : v0,
            manager_id : 0x2::object::uid_to_inner(&v2.id),
        };
        (v2, v3)
    }

    public fun burn_capsule<T0: drop>(arg0: &mut CapsuleManager<T0>, arg1: 0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule::SuilendCapsule, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"common")) {
            arg0.amounts.common
        } else if (0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"uncommon")) {
            arg0.amounts.uncommon
        } else {
            assert!(0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"rare"), 2);
            arg0.amounts.rare
        };
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance), 1);
        0xd4bfdc2c61eda39fe286eb0c844b11daa24f9529e8c04be6c082c0d6a62e8a6a::suilend_capsule::burn(arg1, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun destroy<T0: drop>(arg0: AdminCap<T0>, arg1: CapsuleManager<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        assert!(arg0.manager_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        let CapsuleManager {
            id       : v0,
            admin_id : _,
            balance  : v2,
            amounts  : _,
        } = arg1;
        0x2::object::delete(v0);
        let AdminCap {
            id         : v4,
            manager_id : _,
        } = arg0;
        0x2::object::delete(v4);
        0x2::coin::from_balance<T0>(v2, arg2)
    }

    public fun fund<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut CapsuleManager<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    // decompiled from Move bytecode v6
}

