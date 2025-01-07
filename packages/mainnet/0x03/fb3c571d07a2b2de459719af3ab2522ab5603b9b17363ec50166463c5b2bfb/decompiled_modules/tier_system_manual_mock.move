module 0x3fb3c571d07a2b2de459719af3ab2522ab5603b9b17363ec50166463c5b2bfb::tier_system_manual_mock {
    struct UsersAllocations has store {
        registry: 0x2::table::Table<address, u64>,
    }

    struct TierSystem has key {
        id: 0x2::object::UID,
        allocations: 0x2::table::Table<address, UsersAllocations>,
        managers: vector<address>,
    }

    struct TierSystemOwner has key {
        id: 0x2::object::UID,
    }

    struct NewManager has copy, drop {
        manager: address,
    }

    struct RevokeManager has copy, drop {
        manager: address,
    }

    public fun change_owner(arg0: TierSystemOwner, arg1: address) {
        0x2::transfer::transfer<TierSystemOwner>(arg0, arg1);
    }

    public entry fun get_allocation(arg0: &TierSystem, arg1: address, arg2: address) : u64 {
        *0x2::table::borrow<address, u64>(&0x2::table::borrow<address, UsersAllocations>(&arg0.allocations, arg1).registry, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TierSystemOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TierSystemOwner>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TierSystem{
            id          : 0x2::object::new(arg0),
            allocations : 0x2::table::new<address, UsersAllocations>(arg0),
            managers    : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<TierSystem>(v1);
    }

    public entry fun revoke_managers(arg0: &TierSystemOwner, arg1: &mut TierSystem, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let (v2, v3) = 0x1::vector::index_of<address>(&arg1.managers, &v1);
            assert!(v2, 3);
            0x1::vector::remove<address>(&mut arg1.managers, v3);
            let v4 = RevokeManager{manager: v1};
            0x2::event::emit<RevokeManager>(v4);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public entry fun set_managers(arg0: &TierSystemOwner, arg1: &mut TierSystem, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x1::vector::contains<address>(&arg1.managers, &v1), 2);
            0x1::vector::push_back<address>(&mut arg1.managers, v1);
            let v2 = NewManager{manager: v1};
            0x2::event::emit<NewManager>(v2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public entry fun setup_allocations(arg0: &mut TierSystem, arg1: address, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.managers, &v0), 1);
        if (!0x2::table::contains<address, UsersAllocations>(&arg0.allocations, arg1)) {
            let v1 = UsersAllocations{registry: 0x2::table::new<address, u64>(arg4)};
            0x2::table::add<address, UsersAllocations>(&mut arg0.allocations, arg1, v1);
        };
        let v2 = 0;
        let v3 = 0x2::table::borrow_mut<address, UsersAllocations>(&mut arg0.allocations, arg1);
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v2);
            if (!0x2::table::contains<address, u64>(&v3.registry, v4)) {
                0x2::table::add<address, u64>(&mut v3.registry, v4, *0x1::vector::borrow<u64>(&arg3, v2));
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut v3.registry, v4) = *0x1::vector::borrow<u64>(&arg3, v2);
            };
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

