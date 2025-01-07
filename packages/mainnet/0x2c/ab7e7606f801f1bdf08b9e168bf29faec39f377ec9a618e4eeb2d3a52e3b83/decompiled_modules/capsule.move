module 0x2cab7e7606f801f1bdf08b9e168bf29faec39f377ec9a618e4eeb2d3a52e3b83::capsule {
    struct CapsuleManager<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        version: u64,
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

    struct BurnEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        claim_amount: u64,
        rarity: 0x1::string::String,
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
            version  : 0,
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

    public(friend) fun assert_version<T0: drop>(arg0: &CapsuleManager<T0>) {
        assert!(arg0.version == 0, 999);
    }

    public(friend) fun assert_version_and_upgrade<T0: drop>(arg0: &mut CapsuleManager<T0>) {
        if (arg0.version < 0) {
            arg0.version = 0;
        };
        assert_version<T0>(arg0);
    }

    public fun burn_capsule<T0: drop>(arg0: &mut CapsuleManager<T0>, arg1: 0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::SuilendCapsule, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = if (0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"common")) {
            arg0.amounts.common
        } else if (0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"uncommon")) {
            arg0.amounts.uncommon
        } else {
            assert!(0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::rarity(&arg1) == 0x1::string::utf8(b"rare"), 2);
            arg0.amounts.rare
        };
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance), 1);
        let v1 = BurnEvent{
            manager_id   : 0x2::object::uid_to_inner(&arg0.id),
            claim_amount : v0,
            rarity       : 0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::rarity(&arg1),
        };
        0x2::event::emit<BurnEvent>(v1);
        0xe225a46bfe059ab96f3264d3aee63c6c4997eccad2b4630350e0957a52badd54::suilend_capsule::burn(arg1, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun destroy<T0: drop>(arg0: AdminCap<T0>, arg1: CapsuleManager<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = &mut arg1;
        assert_version_and_upgrade<T0>(v0);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        assert!(arg0.manager_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        let CapsuleManager {
            id       : v1,
            version  : _,
            admin_id : _,
            balance  : v4,
            amounts  : _,
        } = arg1;
        0x2::object::delete(v1);
        let AdminCap {
            id         : v6,
            manager_id : _,
        } = arg0;
        0x2::object::delete(v6);
        0x2::coin::from_balance<T0>(v4, arg2)
    }

    public fun fund<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut CapsuleManager<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.admin_id, 0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun migrate<T0: drop>(arg0: &AdminCap<T0>, arg1: &mut CapsuleManager<T0>) {
        assert!(arg1.version < 0, 999);
        arg1.version = 0;
    }

    // decompiled from Move bytecode v6
}

