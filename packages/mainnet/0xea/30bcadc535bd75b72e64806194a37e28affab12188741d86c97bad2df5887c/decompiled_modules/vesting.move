module 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCapVault has store, key {
        id: 0x2::object::UID,
        owner: 0x1::option::Option<address>,
        to: 0x1::option::Option<address>,
        cap: 0x1::option::Option<AdminCap>,
    }

    struct FundAddedEvent has copy, drop {
        owner: address,
        project: address,
        fund: u128,
    }

    struct FundRemoveEvent has copy, drop {
        owner: address,
        project: address,
        fund: u128,
    }

    struct FundClaimEvent has copy, drop {
        owner: address,
        project: address,
        total: u128,
        released: u128,
        claim: u128,
    }

    struct ProjectCreatedEvent has copy, drop {
        project: address,
        name: vector<u8>,
        url: vector<u8>,
    }

    struct Fund<phantom T0> has store {
        owner: address,
        total: u128,
        locked: 0x2::coin::Coin<T0>,
        released: u128,
        last_claim_ms: u64,
    }

    struct Project<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        url: vector<u8>,
        deprecated: bool,
        tge_ms: u64,
        supply: u128,
        deposited: u128,
        deposited_percent: u128,
        funds: 0x2::table::Table<address, Fund<T0>>,
        vesting_type: u8,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        fee: u64,
        feeTreasury: 0x2::coin::Coin<0x2::sui::SUI>,
        paused: bool,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        projects: 0x2::table::Table<address, u64>,
        user_projects: 0x2::table::Table<address, vector<address>>,
    }

    public entry fun acceptAdmin(arg0: &mut AdminCapVault, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg1, 1);
        let v0 = *0x1::option::borrow<address>(&arg0.to);
        execTransferAdmin(arg0, v0, arg1, arg2);
    }

    public entry fun addFund<T0>(arg0: &AdminCap, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut Project<T0>, arg4: &mut ProjectRegistry, arg5: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg5, 1);
        assert!(!arg3.deprecated, 8009);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 > 0, 8001);
        arg3.deposited = arg3.deposited + v0;
        assert!(arg3.deposited <= arg3.supply, 8007);
        arg3.deposited_percent = arg3.deposited * 10000 / arg3.supply;
        if (0x2::table::contains<address, Fund<T0>>(&mut arg3.funds, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Fund<T0>>(&mut arg3.funds, arg1);
            v1.total = v1.total + v0;
            0x2::coin::join<T0>(&mut v1.locked, arg2);
        } else {
            let v2 = Fund<T0>{
                owner         : arg1,
                total         : v0,
                locked        : arg2,
                released      : 0,
                last_claim_ms : 0,
            };
            0x2::table::add<address, Fund<T0>>(&mut arg3.funds, arg1, v2);
        };
        let v3 = 0x2::object::id_address<Project<T0>>(arg3);
        addProjectToRegistry(arg4, arg1, v3);
        let v4 = FundAddedEvent{
            owner   : arg1,
            project : v3,
            fund    : v0,
        };
        0x2::event::emit<FundAddedEvent>(v4);
    }

    public entry fun addFunds<T0>(arg0: &AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: 0x2::coin::Coin<T0>, arg4: &mut Project<T0>, arg5: &mut ProjectRegistry, arg6: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        let v1 = 0;
        assert!(0x1::vector::length<u64>(&arg2) == v0, 8001);
        while (v1 < v0) {
            addFund<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v1), 0x2::coin::split<T0>(&mut arg3, *0x1::vector::borrow<u64>(&arg2, v1), arg7), arg4, arg5, arg6);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg7));
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

    public entry fun claim<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Project<T0>, arg2: &0x2::clock::Clock, arg3: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg4: &mut ProjectRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg3, 1);
        assert!(!arg1.paused, 8010);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1.fee, 8008);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.tge_ms, 8002);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Fund<T0>>(&arg1.funds, v1), 8004);
        let v2 = (computeClaimPercent<T0>(arg1, v0) as u128);
        assert!(v2 > 0, 8004);
        let v3 = 0x2::table::borrow_mut<address, Fund<T0>>(&mut arg1.funds, v1);
        assert!(v1 == v3.owner, 8003);
        let v4 = v3.total * v2 / 10000;
        assert!(v4 > v3.released, 8004);
        let v5 = v4 - v3.released;
        arg1.deposited = arg1.deposited - v5;
        arg1.deposited_percent = arg1.deposited * 10000 / arg1.supply;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.locked, (v5 as u64), arg5), v1);
        v3.released = v3.released + v5;
        v3.last_claim_ms = v0;
        if (v3.released == v3.total) {
            removeProjectFromRegistry(arg4, v1, 0x2::object::id_address<Project<T0>>(arg1));
        };
        if (arg1.fee > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut arg1.feeTreasury, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1.fee, arg5));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg5));
        let v6 = FundClaimEvent{
            owner    : v3.owner,
            project  : 0x2::object::id_address<Project<T0>>(arg1),
            total    : v3.total,
            released : v3.released,
            claim    : v5,
        };
        0x2::event::emit<FundClaimEvent>(v6);
    }

    fun computeClaimPercent<T0>(arg0: &Project<T0>, arg1: u64) : u64 {
        let v0 = &arg0.milestone_times;
        let v1 = &arg0.milestone_percents;
        let v2 = arg0.tge_ms;
        let v3 = 0;
        let v4 = v3;
        if (arg0.vesting_type == 2) {
            if (arg1 >= v2 + arg0.cliff_ms) {
                v4 = v3 + arg0.unlock_percent;
                let v5 = 0;
                while (v5 < 0x1::vector::length<u64>(v0)) {
                    if (arg1 >= *0x1::vector::borrow<u64>(v0, v5)) {
                        v4 = v4 + *0x1::vector::borrow<u64>(v1, v5);
                        v5 = v5 + 1;
                    } else {
                        break
                    };
                };
            };
        } else if (arg0.vesting_type == 1) {
            if (arg1 >= v2) {
                v4 = v3 + arg0.unlock_percent;
                if (arg1 >= v2 + arg0.cliff_ms) {
                    let v6 = 0;
                    while (v6 < 0x1::vector::length<u64>(v0)) {
                        if (arg1 >= *0x1::vector::borrow<u64>(v0, v6)) {
                            v4 = v4 + *0x1::vector::borrow<u64>(v1, v6);
                            v6 = v6 + 1;
                        } else {
                            break
                        };
                    };
                };
            };
        } else if (arg0.vesting_type == 3) {
            if (arg1 >= v2) {
                let v7 = v3 + arg0.unlock_percent;
                v4 = v7;
                if (arg1 >= v2 + arg0.cliff_ms) {
                    v4 = v7 + (arg1 - v2 - arg0.cliff_ms) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
                };
            };
        } else if (arg0.vesting_type == 4) {
            if (arg1 >= v2 + arg0.cliff_ms) {
                v4 = v3 + arg0.unlock_percent + (arg1 - v2 - arg0.cliff_ms) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
            };
        };
        0x2::math::min(v4, 10000)
    }

    public entry fun createProject<T0>(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u128, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg13: u64, arg14: &mut ProjectRegistry, arg15: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg12, 1);
        assert!(arg5 >= 1 && arg5 <= 4, 8005);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg11) && arg3 > 0 && 0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg2) > 0 && arg7 >= 0 && arg7 <= 10000 && arg6 >= 0, 8001);
        if (arg5 == 2 || arg5 == 1) {
            assert!(0x1::vector::length<u64>(&arg9) == 0x1::vector::length<u64>(&arg10) && 0x1::vector::length<u64>(&arg9) >= 0 && arg8 == 0, 8006);
            let v0 = arg7;
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg9)) {
                v0 = v0 + *0x1::vector::borrow<u64>(&arg10, v1);
                let v2 = *0x1::vector::borrow<u64>(&arg9, v1);
                assert!(v2 >= arg4 + arg6 && v2 > 0, 8006);
                v1 = v1 + 1;
            };
            assert!(v0 == 10000, 8006);
        } else {
            assert!(0x1::vector::length<u64>(&arg9) == 0 && 0x1::vector::length<u64>(&arg10) == 0 && arg8 > 0 && arg8 < 311040000000, 8006);
        };
        let v3 = Project<T0>{
            id                         : 0x2::object::new(arg15),
            name                       : arg1,
            url                        : arg2,
            deprecated                 : false,
            tge_ms                     : arg4,
            supply                     : arg3,
            deposited                  : 0,
            deposited_percent          : 0,
            funds                      : 0x2::table::new<address, Fund<T0>>(arg15),
            vesting_type               : arg5,
            cliff_ms                   : arg6,
            unlock_percent             : arg7,
            linear_vesting_duration_ms : arg8,
            milestone_times            : arg9,
            milestone_percents         : arg10,
            fee                        : arg13,
            feeTreasury                : 0x2::coin::zero<0x2::sui::SUI>(arg15),
            paused                     : false,
        };
        let v4 = 0x2::object::id_address<Project<T0>>(&v3);
        0x2::table::add<address, u64>(&mut arg14.projects, v4, 0);
        let v5 = ProjectCreatedEvent{
            project : v4,
            name    : arg1,
            url     : arg2,
        };
        0x2::event::emit<ProjectCreatedEvent>(v5);
        0x2::transfer::share_object<Project<T0>>(v3);
    }

    fun execTransferAdmin(arg0: &mut AdminCapVault, arg1: address, arg2: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg2, 1);
        assert!(0x1::option::is_some<AdminCap>(&arg0.cap) && arg1 == 0x2::tx_context::sender(arg3), 8003);
        0x2::transfer::transfer<AdminCap>(0x1::option::extract<AdminCap>(&mut arg0.cap), 0x2::tx_context::sender(arg3));
        0x1::option::extract<address>(&mut arg0.owner);
        0x1::option::extract<address>(&mut arg0.to);
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = ProjectRegistry{
            id            : 0x2::object::new(arg1),
            projects      : 0x2::table::new<address, u64>(arg1),
            user_projects : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v1);
        let v2 = AdminCapVault{
            id    : 0x2::object::new(arg1),
            owner : 0x1::option::none<address>(),
            to    : 0x1::option::none<address>(),
            cap   : 0x1::option::none<AdminCap>(),
        };
        0x2::transfer::share_object<AdminCapVault>(v2);
    }

    public entry fun pauseProject<T0>(arg0: &AdminCap, arg1: &mut Project<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun removeFund<T0>(arg0: &AdminCap, arg1: address, arg2: &mut Project<T0>, arg3: &mut ProjectRegistry, arg4: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg4, 1);
        assert!(0x2::table::contains<address, Fund<T0>>(&mut arg2.funds, arg1), 8004);
        let Fund {
            owner         : v0,
            total         : _,
            locked        : v2,
            released      : _,
            last_claim_ms : _,
        } = 0x2::table::remove<address, Fund<T0>>(&mut arg2.funds, arg1);
        let v5 = v2;
        let v6 = (0x2::coin::value<T0>(&v5) as u128);
        assert!(arg2.deposited >= v6, 8011);
        arg2.deposited = arg2.deposited - v6;
        arg2.deposited_percent = arg2.deposited * 10000 / arg2.supply;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg5));
        removeProjectFromRegistry(arg3, v0, 0x2::object::id_address<Project<T0>>(arg2));
        let v7 = FundRemoveEvent{
            owner   : v0,
            project : 0x2::object::id_address<Project<T0>>(arg2),
            fund    : v6,
        };
        0x2::event::emit<FundRemoveEvent>(v7);
    }

    public entry fun removeFunds<T0>(arg0: &AdminCap, arg1: vector<address>, arg2: &mut Project<T0>, arg3: &mut ProjectRegistry, arg4: &0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            removeFund<T0>(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2, arg3, arg4, arg5);
            v0 = v0 + 1;
        };
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

    public entry fun revokeAdmin(arg0: &mut AdminCapVault, arg1: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg1, 1);
        let v0 = *0x1::option::borrow<address>(&arg0.owner);
        execTransferAdmin(arg0, v0, arg1, arg2);
    }

    public entry fun setDeprecated<T0>(arg0: &AdminCap, arg1: &mut Project<T0>, arg2: bool) {
        arg1.deprecated = arg2;
    }

    public entry fun setProjectFee<T0>(arg0: &AdminCap, arg1: &mut Project<T0>, arg2: u64) {
        arg1.fee = arg2;
    }

    public entry fun transferAdmin(arg0: AdminCap, arg1: address, arg2: &mut AdminCapVault, arg3: &mut 0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xea30bcadc535bd75b72e64806194a37e28affab12188741d86c97bad2df5887c::version::checkVersion(arg3, 1);
        0x1::option::fill<address>(&mut arg2.owner, 0x2::tx_context::sender(arg4));
        0x1::option::fill<address>(&mut arg2.to, arg1);
        0x1::option::fill<AdminCap>(&mut arg2.cap, arg0);
    }

    public entry fun withdrawFee<T0>(arg0: &AdminCap, arg1: address, arg2: &mut Project<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2.feeTreasury, 0x2::coin::value<0x2::sui::SUI>(&arg2.feeTreasury), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

