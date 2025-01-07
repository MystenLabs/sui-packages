module 0xccc1ce6e9f9d90e6c652dc3088ed94a7277bc891caba88ccea0217436f83ce12::staking_module {
    struct Admin has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct Status has drop, store {
        id: 0x2::object::ID,
        can_deposit: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        collection: 0x1::type_name::TypeName,
        containers: vector<Status>,
        container_maximum_size: u64,
        is_enable: bool,
        start_time: u64,
        end_time: u64,
        duration: u64,
        item_per_ticket: u64,
    }

    struct Container has key {
        id: 0x2::object::UID,
        count: u64,
        collection: 0x1::type_name::TypeName,
    }

    struct StakingItem<T0: store + key> has store, key {
        id: 0x2::object::UID,
        container_id: 0x2::object::ID,
        owner: address,
        item: T0,
        duration: u64,
        is_unstake: bool,
    }

    struct CreatePoolEvent has copy, drop {
        pool: 0x2::object::ID,
        collection: 0x1::type_name::TypeName,
        start_time: u64,
        end_time: u64,
        duration: u64,
        item_per_ticket: u64,
    }

    struct StakeEvent has copy, drop {
        pool: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        container_id: 0x2::object::ID,
    }

    struct UnStakeEvent has copy, drop {
        nft_id: 0x2::object::ID,
        pool: 0x2::object::ID,
        nft_duration: u64,
    }

    struct ClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public entry fun add_admin(arg0: &mut Admin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 0);
        0x1::vector::append<address>(&mut arg0.admins, arg1);
    }

    public fun change_container_status(arg0: &mut Pool, arg1: &mut Container, arg2: bool) {
        let v0 = &mut arg0.containers;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Status>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Status>(v0, v1);
            if (v2.id == 0x2::object::id<Container>(arg1)) {
                v2.can_deposit = arg2;
                break
            };
            v1 = v1 + 1;
        };
    }

    public entry fun change_pool_duration(arg0: &mut Admin, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg3)) == true, 0);
        arg1.duration = arg2;
    }

    public entry fun change_pool_status(arg0: &mut Admin, arg1: &mut Pool, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg3)) == true, 0);
        arg1.is_enable = arg2;
    }

    fun create_new_container<T0: store + key>(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) : Container {
        let v0 = Container{
            id         : 0x2::object::new(arg1),
            count      : 1,
            collection : 0x1::type_name::get<T0>(),
        };
        let v1 = Status{
            id          : 0x2::object::id<Container>(&v0),
            can_deposit : true,
        };
        0x1::vector::push_back<Status>(&mut arg0.containers, v1);
        v0
    }

    public entry fun create_new_pool<T0: store + key>(arg0: &mut Admin, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg5)) == true, 0);
        let v0 = Pool{
            id                     : 0x2::object::new(arg5),
            collection             : 0x1::type_name::get<T0>(),
            containers             : 0x1::vector::empty<Status>(),
            container_maximum_size : 100,
            is_enable              : true,
            start_time             : arg2,
            end_time               : arg3,
            duration               : arg4,
            item_per_ticket        : arg1,
        };
        let v1 = Container{
            id         : 0x2::object::new(arg5),
            count      : 0,
            collection : 0x1::type_name::get<T0>(),
        };
        let v2 = CreatePoolEvent{
            pool            : 0x2::object::id<Pool>(&v0),
            collection      : 0x1::type_name::get<T0>(),
            start_time      : arg2,
            end_time        : arg3,
            duration        : arg4,
            item_per_ticket : arg1,
        };
        0x2::event::emit<CreatePoolEvent>(v2);
        let v3 = Status{
            id          : 0x2::object::id<Container>(&v1),
            can_deposit : true,
        };
        0x1::vector::push_back<Status>(&mut v0.containers, v3);
        0x2::transfer::share_object<Container>(v1);
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun existed<T0: store + key>(arg0: &mut Admin, arg1: &mut Pool, arg2: &mut Container, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let StakingItem {
            id           : v0,
            container_id : _,
            owner        : v2,
            item         : v3,
            duration     : _,
            is_unstake   : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, StakingItem<T0>>(&mut arg2.id, arg3);
        let v6 = v3;
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg4)) == true, 6003);
        let v7 = ClaimEvent{
            nft_id : 0x2::object::id<T0>(&v6),
            pool   : 0x2::object::id<Pool>(arg1),
        };
        0x2::event::emit<ClaimEvent>(v7);
        change_container_status(arg1, arg2, true);
        arg2.count = arg2.count - 1;
        0x2::transfer::public_transfer<T0>(v6, v2);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Admin{
            id     : 0x2::object::new(arg0),
            admins : v0,
        };
        0x2::transfer::share_object<Admin>(v1);
    }

    public fun isAdmin(arg0: &mut Admin, arg1: address) : bool {
        let v0 = false;
        let v1 = arg0.admins;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            if (*0x1::vector::borrow<address>(&v1, v2) == arg1) {
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun make_claim<T0: store + key>(arg0: &mut Admin, arg1: &mut Pool, arg2: &mut Container, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_enable == true, 5006);
        let StakingItem {
            id           : v0,
            container_id : _,
            owner        : v2,
            item         : v3,
            duration     : v4,
            is_unstake   : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, StakingItem<T0>>(&mut arg2.id, arg3);
        let v6 = v3;
        let v7 = 0x2::tx_context::sender(arg5);
        assert!(v7 == v2 || isAdmin(arg0, v7) == true, 6003);
        assert!(v5 == true, 6005);
        assert!(0x2::clock::timestamp_ms(arg4) > v4, 6004);
        let v8 = ClaimEvent{
            nft_id : 0x2::object::id<T0>(&v6),
            pool   : 0x2::object::id<Pool>(arg1),
        };
        0x2::event::emit<ClaimEvent>(v8);
        change_container_status(arg1, arg2, true);
        arg2.count = arg2.count - 1;
        0x2::transfer::public_transfer<T0>(v6, v2);
        0x2::object::delete(v0);
    }

    public entry fun make_stake<T0: store + key>(arg0: &mut Pool, arg1: &mut Container, arg2: T0, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.is_enable == true, 5006);
        assert!(arg0.collection == 0x1::type_name::get<T0>(), 6002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 6001);
        if (arg1.count >= arg0.container_maximum_size) {
            let v2 = create_new_container<T0>(arg0, arg4);
            let v3 = 0x2::object::id<T0>(&arg2);
            let v4 = StakeEvent{
                pool         : 0x2::object::id<Pool>(arg0),
                nft_id       : v3,
                container_id : 0x2::object::id<Container>(&v2),
            };
            0x2::event::emit<StakeEvent>(v4);
            let v5 = StakingItem<T0>{
                id           : 0x2::object::new(arg4),
                container_id : 0x2::object::id<Container>(&v2),
                owner        : v0,
                item         : arg2,
                duration     : 0,
                is_unstake   : false,
            };
            0x2::dynamic_object_field::add<0x2::object::ID, StakingItem<T0>>(&mut v2.id, v3, v5);
            0x2::transfer::share_object<Container>(v2);
        } else {
            assert!(arg1.collection == 0x1::type_name::get<T0>(), 6002);
            let v6 = 0x2::object::id<T0>(&arg2);
            let v7 = StakeEvent{
                pool         : 0x2::object::id<Pool>(arg0),
                nft_id       : v6,
                container_id : 0x2::object::id<Container>(arg1),
            };
            0x2::event::emit<StakeEvent>(v7);
            let v8 = StakingItem<T0>{
                id           : 0x2::object::new(arg4),
                container_id : 0x2::object::id<Container>(arg1),
                owner        : v0,
                item         : arg2,
                duration     : 0,
                is_unstake   : false,
            };
            if (arg1.count + 1 == arg0.container_maximum_size) {
                change_container_status(arg0, arg1, false);
            };
            arg1.count = arg1.count + 1;
            0x2::dynamic_object_field::add<0x2::object::ID, StakingItem<T0>>(&mut arg1.id, v6, v8);
        };
    }

    public entry fun make_unstake<T0: store + key>(arg0: &mut Admin, arg1: &mut Pool, arg2: &mut Container, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_enable == true, 5006);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, StakingItem<T0>>(&mut arg2.id, arg3);
        let v1 = &mut v0.item;
        let v2 = &mut v0.duration;
        let v3 = &mut v0.is_unstake;
        let v4 = 0x2::tx_context::sender(arg5);
        assert!(v4 == v0.owner || isAdmin(arg0, v4) == true, 6003);
        assert!(*v3 == false, 6006);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        *v2 = v5 + arg1.duration;
        *v3 = true;
        let v6 = UnStakeEvent{
            nft_id       : 0x2::object::id<T0>(v1),
            pool         : 0x2::object::id<Pool>(arg1),
            nft_duration : v5 + arg1.duration,
        };
        0x2::event::emit<UnStakeEvent>(v6);
    }

    public entry fun remove_admin(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 0);
        let v1 = 0;
        let v2 = arg0.admins;
        let v3 = false;
        while (v1 < 0x1::vector::length<address>(&v2)) {
            if (*0x1::vector::borrow<address>(&v2, v1) == arg1) {
                v3 = true;
            };
            v1 = v1 + 1;
        };
        if (v3 == true) {
            0x1::vector::remove<address>(&mut v2, 0);
        };
    }

    // decompiled from Move bytecode v6
}

