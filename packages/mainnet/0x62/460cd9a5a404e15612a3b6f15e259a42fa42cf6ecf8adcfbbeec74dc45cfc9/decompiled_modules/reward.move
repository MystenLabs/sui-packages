module 0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::reward {
    struct REWARD has drop {
        dummy_field: bool,
    }

    struct RewardAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardAdminCapVault has store, key {
        id: 0x2::object::UID,
        owner: 0x1::option::Option<address>,
        to: 0x1::option::Option<address>,
        cap: 0x1::option::Option<RewardAdminCap>,
    }

    struct RewardAddedEvent has copy, drop {
        owner: address,
        project: address,
        fund: u128,
    }

    struct RewardRemoveEvent has copy, drop {
        owner: address,
        project: address,
        fund: u128,
    }

    struct RewardClaimEvent has copy, drop {
        owner: address,
        project: address,
        total: u128,
        released: u128,
        claim: u128,
    }

    struct ProjectCreatedEvent has copy, drop {
        project: address,
        name: vector<u8>,
    }

    struct Reward<phantom T0> has store {
        owner: address,
        total: u128,
        fund: 0x2::coin::Coin<T0>,
        released: u128,
        last_claim_ms: u64,
        tge_ms: u64,
        vesting_duration_ms: u64,
    }

    struct Project<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        deposited: u128,
        funds: 0x2::table::Table<address, Reward<T0>>,
        paused: bool,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        projects: 0x2::table::Table<address, u64>,
        user_projects: 0x2::table::Table<address, vector<address>>,
    }

    public entry fun acceptAdmin(arg0: &mut RewardAdminCapVault, arg1: &mut 0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg1, 1);
        let v0 = *0x1::option::borrow<address>(&arg0.to);
        execTransferAdmin(arg0, v0, arg1, arg2);
    }

    fun addProjectToRegistry(arg0: &mut ProjectRegistry, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_projects, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_projects, arg1);
            let (v1, _) = 0x1::vector::index_of<address>(v0, &arg2);
            if (!v1) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.user_projects, arg1, v3);
        };
    }

    public entry fun addReward<T0>(arg0: &RewardAdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut Project<T0>, arg6: &mut ProjectRegistry, arg7: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg7, 1);
        assert!(!arg5.paused, 8010);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 > 0, 8001);
        arg5.deposited = arg5.deposited + v0;
        if (0x2::table::contains<address, Reward<T0>>(&mut arg5.funds, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Reward<T0>>(&mut arg5.funds, arg1);
            v1.total = v1.total + v0;
            0x2::coin::join<T0>(&mut v1.fund, arg2);
        } else {
            let v2 = Reward<T0>{
                owner               : arg1,
                total               : v0,
                fund                : arg2,
                released            : 0,
                last_claim_ms       : 0,
                tge_ms              : arg3,
                vesting_duration_ms : arg4,
            };
            0x2::table::add<address, Reward<T0>>(&mut arg5.funds, arg1, v2);
        };
        let v3 = 0x2::object::id_address<Project<T0>>(arg5);
        addProjectToRegistry(arg6, arg1, v3);
        let v4 = RewardAddedEvent{
            owner   : arg1,
            project : v3,
            fund    : v0,
        };
        0x2::event::emit<RewardAddedEvent>(v4);
    }

    public entry fun addRewards<T0>(arg0: &RewardAdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: &mut Project<T0>, arg7: &mut ProjectRegistry, arg8: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        assert!(0x1::vector::length<u64>(&arg4) == v0, 8001);
        while (v1 < v0) {
            addReward<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v1), 0x2::coin::split<T0>(&mut arg5, *0x1::vector::borrow<u64>(&arg4, v1), arg9), *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), arg6, arg7, arg8);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, 0x2::tx_context::sender(arg9));
    }

    public entry fun claim<T0>(arg0: &mut Project<T0>, arg1: &0x2::clock::Clock, arg2: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg3: &mut ProjectRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8010);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, Reward<T0>>(&arg0.funds, v0), 8004);
        let v1 = 0x2::table::borrow_mut<address, Reward<T0>>(&mut arg0.funds, v0);
        assert!(v0 == v1.owner, 8003);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 >= v1.tge_ms, 8002);
        let v3 = (computeClaimPercent(v2, v1.tge_ms, v1.vesting_duration_ms) as u128);
        assert!(v3 > 0, 8004);
        let v4 = v1.total * v3 / 10000;
        assert!(v4 > v1.released, 8004);
        let v5 = v4 - v1.released;
        arg0.deposited = arg0.deposited - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.fund, (v5 as u64), arg4), v0);
        v1.released = v1.released + v5;
        v1.last_claim_ms = v2;
        if (v1.released >= v1.total) {
            removeProjectFromRegistry(arg3, v0, 0x2::object::id_address<Project<T0>>(arg0));
        };
        let v6 = RewardClaimEvent{
            owner    : v1.owner,
            project  : 0x2::object::id_address<Project<T0>>(arg0),
            total    : v1.total,
            released : v1.released,
            claim    : v5,
        };
        0x2::event::emit<RewardClaimEvent>(v6);
    }

    fun computeClaimPercent(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        if (arg0 >= arg1) {
            v0 = (arg0 - arg1) * 10000 / arg2;
        };
        0x2::math::min(v0, 10000)
    }

    public entry fun createProject<T0>(arg0: &RewardAdminCap, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg4: &mut ProjectRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg3, 1);
        0x2::clock::timestamp_ms(arg2);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 8001);
        let v0 = Project<T0>{
            id        : 0x2::object::new(arg5),
            name      : arg1,
            deposited : 0,
            funds     : 0x2::table::new<address, Reward<T0>>(arg5),
            paused    : false,
        };
        let v1 = 0x2::object::id_address<Project<T0>>(&v0);
        0x2::table::add<address, u64>(&mut arg4.projects, v1, 0);
        let v2 = ProjectCreatedEvent{
            project : v1,
            name    : arg1,
        };
        0x2::event::emit<ProjectCreatedEvent>(v2);
        0x2::transfer::share_object<Project<T0>>(v0);
    }

    fun execTransferAdmin(arg0: &mut RewardAdminCapVault, arg1: address, arg2: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg2, 1);
        assert!(0x1::option::is_some<RewardAdminCap>(&arg0.cap) && arg1 == 0x2::tx_context::sender(arg3), 8003);
        0x2::transfer::transfer<RewardAdminCap>(0x1::option::extract<RewardAdminCap>(&mut arg0.cap), 0x2::tx_context::sender(arg3));
        0x1::option::extract<address>(&mut arg0.owner);
        0x1::option::extract<address>(&mut arg0.to);
    }

    fun init(arg0: REWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<RewardAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = ProjectRegistry{
            id            : 0x2::object::new(arg1),
            projects      : 0x2::table::new<address, u64>(arg1),
            user_projects : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v1);
        let v2 = RewardAdminCapVault{
            id    : 0x2::object::new(arg1),
            owner : 0x1::option::none<address>(),
            to    : 0x1::option::none<address>(),
            cap   : 0x1::option::none<RewardAdminCap>(),
        };
        0x2::transfer::share_object<RewardAdminCapVault>(v2);
    }

    public entry fun pauseProject<T0>(arg0: &RewardAdminCap, arg1: &mut Project<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    fun removeProjectFromRegistry(arg0: &mut ProjectRegistry, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_projects, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_projects, arg1);
            let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<address>(v0, v2);
            };
            if (0x1::vector::length<address>(v0) == 0) {
                0x2::table::remove<address, vector<address>>(&mut arg0.user_projects, arg1);
            };
        };
    }

    public entry fun removeReward<T0>(arg0: &RewardAdminCap, arg1: address, arg2: &mut Project<T0>, arg3: &mut ProjectRegistry, arg4: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg4, 1);
        assert!(0x2::table::contains<address, Reward<T0>>(&mut arg2.funds, arg1), 8004);
        let Reward {
            owner               : v0,
            total               : _,
            fund                : v2,
            released            : _,
            last_claim_ms       : _,
            tge_ms              : _,
            vesting_duration_ms : _,
        } = 0x2::table::remove<address, Reward<T0>>(&mut arg2.funds, arg1);
        let v7 = v2;
        let v8 = (0x2::coin::value<T0>(&v7) as u128);
        assert!(arg2.deposited >= v8, 8011);
        arg2.deposited = arg2.deposited - v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, 0x2::tx_context::sender(arg5));
        removeProjectFromRegistry(arg3, v0, 0x2::object::id_address<Project<T0>>(arg2));
        let v9 = RewardRemoveEvent{
            owner   : v0,
            project : 0x2::object::id_address<Project<T0>>(arg2),
            fund    : v8,
        };
        0x2::event::emit<RewardRemoveEvent>(v9);
    }

    public entry fun removeRewards<T0>(arg0: &RewardAdminCap, arg1: vector<address>, arg2: &mut Project<T0>, arg3: &mut ProjectRegistry, arg4: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            removeReward<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2, arg3, arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public entry fun revokeAdmin(arg0: &mut RewardAdminCapVault, arg1: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg1, 1);
        let v0 = *0x1::option::borrow<address>(&arg0.owner);
        execTransferAdmin(arg0, v0, arg1, arg2);
    }

    public entry fun transferAdmin(arg0: RewardAdminCap, arg1: address, arg2: &mut RewardAdminCapVault, arg3: &0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x62460cd9a5a404e15612a3b6f15e259a42fa42cf6ecf8adcfbbeec74dc45cfc9::version::checkVersion(arg3, 1);
        0x1::option::fill<address>(&mut arg2.owner, 0x2::tx_context::sender(arg4));
        0x1::option::fill<address>(&mut arg2.to, arg1);
        0x1::option::fill<RewardAdminCap>(&mut arg2.cap, arg0);
    }

    // decompiled from Move bytecode v6
}

