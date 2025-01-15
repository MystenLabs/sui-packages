module 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::vesting {
    struct VESTING has drop {
        dummy_field: bool,
    }

    struct Admincap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Operation has store, key {
        id: 0x2::object::UID,
        operationWallet: address,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        member: 0x1::option::Option<address>,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u64>,
        user_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct Fund has drop, store {
        owner: address,
        total: u128,
        locked: u128,
        released: u128,
        last_claim_ms: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        state: u8,
        type_coin_name: 0x1::type_name::TypeName,
        vesting_type: u8,
        tge_ms: u64,
        cliff_ms: u64,
        unlock_percent: u64,
        linear_vesting_duration_ms: u64,
        milestone_times: vector<u64>,
        milestone_percents: vector<u64>,
        funds: 0x2::table::Table<address, Fund>,
        funds_total: 0x2::coin::Coin<T0>,
        funds_claimed: u128,
        enable_change_fund: bool,
        linear_step: u128,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: address,
    }

    struct UpdateVestingEvent has copy, drop {
        pool_id: address,
    }

    struct AddFundEvent has copy, drop {
        pool_id: address,
        user: address,
        fund_amount: u128,
    }

    struct AddFundReleasedEvent has copy, drop {
        pool_id: address,
        user: address,
        fund_amount: u128,
        released_amount: u128,
    }

    struct RemoveFundEvent has copy, drop {
        pool_id: address,
        user: address,
        fund_amount: u128,
    }

    struct ClaimFundEvent has copy, drop {
        pool_id: address,
        owner: address,
        total: u128,
        locked: u128,
        released: u128,
        claim: u128,
    }

    struct DepositFundEvent has copy, drop {
        pool_id: address,
        user: address,
        amount: u128,
    }

    struct WithdrawFundEvent has copy, drop {
        user: address,
        fund_amount: u128,
    }

    struct ChangeOperationWalletEvent has copy, drop {
        new_operation_wallet: address,
    }

    struct ChangeMemberInVaultEvent has copy, drop {
        new_member: address,
    }

    struct AddMemberInVaultEvent has copy, drop {
        member: address,
    }

    public fun addFunds<T0>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg6, 1);
        assert!(0x1::vector::length<u128>(&arg4) == 0x1::vector::length<address>(&arg5), 1006);
        assert!(arg2.enable_change_fund, 1007);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            let v1 = *0x1::vector::borrow<address>(&arg5, v0);
            let v2 = *0x1::vector::borrow<u128>(&arg4, v0);
            let (v3, v4, _) = getFundUser<T0>(arg2, v1);
            if (v3 > 0 || v3 > 0 && v4 == 0) {
                let v6 = 0x2::table::borrow_mut<address, Fund>(&mut arg2.funds, v1);
                v6.total = v6.total + v2;
                v6.locked = v6.locked + v2;
            } else {
                let v7 = Fund{
                    owner         : v1,
                    total         : v2,
                    locked        : v2,
                    released      : 0,
                    last_claim_ms : 0,
                };
                0x2::table::add<address, Fund>(&mut arg2.funds, v1, v7);
            };
            addPoolToRegistry(arg1, v1, 0x2::object::id_address<Pool<T0>>(arg2));
            0x2::coin::join<T0>(&mut arg2.funds_total, 0x2::coin::split<T0>(&mut arg3, (v2 as u64), arg7));
            let v8 = AddFundEvent{
                pool_id     : 0x2::object::id_address<Pool<T0>>(arg2),
                user        : v1,
                fund_amount : v2,
            };
            0x2::event::emit<AddFundEvent>(v8);
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg7));
    }

    public fun addFundsWithReleased<T0>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u128>, arg5: vector<address>, arg6: vector<u128>, arg7: bool, arg8: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg8, 1);
        assert!(0x1::vector::length<u128>(&arg4) == 0x1::vector::length<address>(&arg5) && 0x1::vector::length<address>(&arg5) == 0x1::vector::length<u128>(&arg6), 1006);
        assert!(arg2.enable_change_fund, 1007);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            let v1 = *0x1::vector::borrow<address>(&arg5, v0);
            let v2 = *0x1::vector::borrow<u128>(&arg4, v0);
            let v3 = *0x1::vector::borrow<u128>(&arg6, v0);
            let (v4, v5, _) = getFundUser<T0>(arg2, v1);
            if (v4 > 0 || v4 > 0 && v5 == 0) {
                let v7 = 0x2::table::borrow_mut<address, Fund>(&mut arg2.funds, v1);
                v7.total = v7.total + v2;
                v7.locked = v7.locked + v2;
                v7.released = v7.released + v3;
            } else {
                let v8 = Fund{
                    owner         : v1,
                    total         : v2,
                    locked        : v2,
                    released      : v3,
                    last_claim_ms : 0,
                };
                0x2::table::add<address, Fund>(&mut arg2.funds, v1, v8);
            };
            if (arg7) {
                arg2.funds_claimed = arg2.funds_claimed + v3;
            };
            addPoolToRegistry(arg1, v1, 0x2::object::id_address<Pool<T0>>(arg2));
            0x2::coin::join<T0>(&mut arg2.funds_total, 0x2::coin::split<T0>(&mut arg3, (v2 as u64), arg9));
            let v9 = AddFundReleasedEvent{
                pool_id         : 0x2::object::id_address<Pool<T0>>(arg2),
                user            : v1,
                fund_amount     : v2,
                released_amount : v3,
            };
            0x2::event::emit<AddFundReleasedEvent>(v9);
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg9));
    }

    public fun addMemberInVault(arg0: &Admincap, arg1: address, arg2: &mut Vault, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg3, 1);
        assert!(!0x1::option::is_some<address>(&arg2.member), 1013);
        0x1::option::fill<address>(&mut arg2.member, arg1);
        let v0 = AddMemberInVaultEvent{member: arg1};
        0x2::event::emit<AddMemberInVaultEvent>(v0);
    }

    fun addPoolToRegistry(arg0: &mut ProjectRegistry, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_pools, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_pools, arg1);
            let (v1, _) = 0x1::vector::index_of<address>(v0, &arg2);
            if (!v1) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.user_pools, arg1, v3);
        };
    }

    public fun changeMemberInVault(arg0: &Admincap, arg1: address, arg2: &mut Vault, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg3, 1);
        assert!(0x1::option::is_some<address>(&arg2.member) && arg1 != *0x1::option::borrow<address>(&arg2.member), 1013);
        0x1::option::swap<address>(&mut arg2.member, arg1);
        let v0 = ChangeMemberInVaultEvent{new_member: arg1};
        0x2::event::emit<ChangeMemberInVaultEvent>(v0);
    }

    public fun changeOperationWallet(arg0: &mut Operation, arg1: &Vault, arg2: address, arg3: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg3, 1);
        assert!(arg2 != arg0.operationWallet, 1013);
        assert!(0x1::option::is_some<address>(&arg1.member) && *0x1::option::borrow<address>(&arg1.member) == 0x2::tx_context::sender(arg4), 1005);
        assert!(arg0.operationWallet == 0x2::tx_context::sender(arg4), 1005);
        arg0.operationWallet = arg2;
        let v0 = ChangeOperationWalletEvent{new_operation_wallet: arg2};
        0x2::event::emit<ChangeOperationWalletEvent>(v0);
    }

    public fun claim<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        let v0 = 0x2::object::id_address<Pool<T0>>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        validateClaimFund<T0>(arg0, v2);
        assert!(v1 >= arg0.tge_ms, 1010);
        let v3 = computeClaimPercent<T0>(arg0, v1);
        assert!(v3 > 0, 1011);
        let (v4, v5, v6) = getFundUser<T0>(arg0, v2);
        let v7 = 0x2::table::borrow_mut<address, Fund>(&mut arg0.funds, v2);
        assert!(v7.owner == v2, 1005);
        let v8 = v4 * (v3 as u128) / 10000;
        assert!(v8 > v6, 1011);
        let v9 = v8 - v6;
        assert!(v5 >= v9, 1011);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.funds_total, (v9 as u64), arg3), v2);
        v7.released = v7.released + v9;
        v7.locked = v7.locked - v9;
        v7.last_claim_ms = v1;
        arg0.funds_claimed = arg0.funds_claimed + v9;
        let v10 = ClaimFundEvent{
            pool_id  : v0,
            owner    : v2,
            total    : v7.total,
            locked   : v7.locked,
            released : v7.released,
            claim    : v9,
        };
        0x2::event::emit<ClaimFundEvent>(v10);
    }

    fun computeClaimPercent<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = arg0.milestone_percents;
        let v1 = arg0.milestone_times;
        let v2 = 0;
        let v3 = v2;
        let v4 = arg0.tge_ms;
        let v5 = arg0.cliff_ms;
        if (arg0.vesting_type == 2) {
            if (arg1 >= v4 + v5) {
                v3 = v2 + arg0.unlock_percent;
                let v6 = 0;
                while (v6 < 0x1::vector::length<u64>(&v1)) {
                    if (arg1 > *0x1::vector::borrow<u64>(&v1, v6)) {
                        v3 = v3 + *0x1::vector::borrow<u64>(&v0, v6);
                    };
                    v6 = v6 + 1;
                };
            };
        } else if (arg0.vesting_type == 1) {
            if (arg1 >= v4) {
                v3 = v2 + arg0.unlock_percent;
                if (arg1 >= v4 + v5) {
                    let v7 = 0;
                    while (v7 < 0x1::vector::length<u64>(&v1)) {
                        if (arg1 >= *0x1::vector::borrow<u64>(&v1, v7)) {
                            v3 = v3 + *0x1::vector::borrow<u64>(&v0, v7);
                        };
                        v7 = v7 + 1;
                    };
                };
            };
        } else if (arg0.vesting_type == 3) {
            if (arg1 >= v4) {
                let v8 = v2 + arg0.unlock_percent;
                v3 = v8;
                if (arg1 >= v4 + v5) {
                    let v9 = arg1 - v4 - v5;
                    v3 = v8 + (v9 - v9 % (arg0.linear_step as u64)) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
                };
            };
        } else if (arg0.vesting_type == 4) {
            if (arg1 >= v4 + v5) {
                let v10 = arg1 - v4 - v5;
                v3 = v2 + arg0.unlock_percent + (v10 - v10 % (arg0.linear_step as u64)) * (10000 - arg0.unlock_percent) / arg0.linear_vesting_duration_ms;
            };
        };
        0x1::u64::min(v3, 10000)
    }

    public fun createPool<T0>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: u128, arg11: &mut 0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg12: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg11, 1);
        validateSetup(arg3, arg6, arg4, arg5, arg7, arg8, arg9, arg10);
        let v0 = Pool<T0>{
            id                         : 0x2::object::new(arg12),
            name                       : arg2,
            state                      : 1,
            type_coin_name             : 0x1::type_name::get<T0>(),
            vesting_type               : arg3,
            tge_ms                     : arg4,
            cliff_ms                   : arg5,
            unlock_percent             : arg6,
            linear_vesting_duration_ms : arg7,
            milestone_times            : arg8,
            milestone_percents         : arg9,
            funds                      : 0x2::table::new<address, Fund>(arg12),
            funds_total                : 0x2::coin::zero<T0>(arg12),
            funds_claimed              : 0,
            enable_change_fund         : true,
            linear_step                : arg10,
        };
        let v1 = 0x2::object::id_address<Pool<T0>>(&v0);
        0x2::table::add<address, u64>(&mut arg1.pools, v1, 0);
        let v2 = CreatePoolEvent{pool_id: v1};
        0x2::event::emit<CreatePoolEvent>(v2);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun depositFund<T0>(arg0: &TreasureCap, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1008);
        0x2::coin::join<T0>(&mut arg1.funds_total, arg2);
        let v1 = DepositFundEvent{
            pool_id : 0x2::object::id_address<Pool<T0>>(arg1),
            user    : 0x2::tx_context::sender(arg4),
            amount  : (v0 as u128),
        };
        0x2::event::emit<DepositFundEvent>(v1);
    }

    public fun disableChangeFund<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        arg1.enable_change_fund = false;
    }

    public fun enableChangeFund<T0>(arg0: &Operation, arg1: &mut Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg3: &Vault, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        assert!(0x2::tx_context::sender(arg4) == arg0.operationWallet, 1005);
        assert!(0x1::option::is_some<address>(&arg3.member) && *0x1::option::borrow<address>(&arg3.member) == 0x2::tx_context::sender(arg4), 1005);
        arg1.enable_change_fund = true;
    }

    public fun end<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        assert!(arg1.state == 2, 1014);
        arg1.state = 4;
    }

    public fun getFundUser<T0>(arg0: &Pool<T0>, arg1: address) : (u128, u128, u128) {
        if (0x2::table::contains<address, Fund>(&arg0.funds, arg1)) {
            let v3 = 0x2::table::borrow<address, Fund>(&arg0.funds, arg1);
            (v3.total, v3.locked, v3.released)
        } else {
            (0, 0, 0)
        }
    }

    fun init(arg0: VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admincap{id: 0x2::object::new(arg1)};
        let v1 = ManagerCap{id: 0x2::object::new(arg1)};
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Admincap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasureCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg1));
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::createVault<Admincap>(arg1);
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::createVault<ManagerCap>(arg1);
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::cap_vault::createVault<TreasureCap>(arg1);
        let v3 = ProjectRegistry{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<address, u64>(arg1),
            user_pools : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v3);
        let v4 = Operation{
            id              : 0x2::object::new(arg1),
            operationWallet : @0x8320647849603591d5e5684289e9a78cd42371ac7a3f89a18136b693af6ef2f4,
        };
        0x2::transfer::share_object<Operation>(v4);
        let v5 = Vault{
            id     : 0x2::object::new(arg1),
            member : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Vault>(v5);
    }

    public fun pause<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        assert!(arg1.state != 3, 1015);
        arg1.state = 3;
    }

    public fun removeFunds<T0>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: &Operation, arg3: &mut Pool<T0>, arg4: vector<address>, arg5: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg5, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            let v1 = *0x1::vector::borrow<address>(&arg4, v0);
            let (_, v3, _) = getFundUser<T0>(arg3, v1);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3.funds_total, (v3 as u64), arg6), arg2.operationWallet);
            };
            0x2::table::remove<address, Fund>(&mut arg3.funds, v1);
            removePoolFromRegistry(arg1, v1, 0x2::object::id_address<Pool<T0>>(arg3));
            let v5 = RemoveFundEvent{
                pool_id     : 0x2::object::id_address<Pool<T0>>(arg3),
                user        : v1,
                fund_amount : v3,
            };
            0x2::event::emit<RemoveFundEvent>(v5);
            v0 = v0 + 1;
        };
    }

    fun removePoolFromRegistry(arg0: &mut ProjectRegistry, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_pools, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_pools, arg1);
            let (v1, v2) = 0x1::vector::index_of<address>(v0, &arg2);
            if (v1) {
                0x1::vector::remove<address>(v0, v2);
            };
            if (0x1::vector::length<address>(v0) == 0) {
                0x2::table::remove<address, vector<address>>(&mut arg0.user_pools, arg1);
            };
        };
    }

    public fun start<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg2, 1);
        assert!(arg1.state == 1 || arg1.state == 3, 1016);
        arg1.state = 2;
    }

    public fun updateVestingConfig<T0>(arg0: &Operation, arg1: &mut Pool<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: u128, arg10: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg11: &Vault, arg12: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg10, 1);
        assert!(0x2::tx_context::sender(arg12) == arg0.operationWallet, 1005);
        assert!(0x1::option::is_some<address>(&arg11.member) && *0x1::option::borrow<address>(&arg11.member) == 0x2::tx_context::sender(arg12), 1005);
        validateSetup(arg2, arg5, arg3, arg4, arg6, arg7, arg8, arg9);
        arg1.vesting_type = arg2;
        arg1.tge_ms = arg3;
        arg1.cliff_ms = arg4;
        arg1.unlock_percent = arg5;
        arg1.linear_vesting_duration_ms = arg6;
        arg1.milestone_times = arg7;
        arg1.milestone_percents = arg8;
        arg1.state = 3;
        arg1.linear_step = arg9;
        let v0 = UpdateVestingEvent{pool_id: 0x2::object::id_address<Pool<T0>>(arg1)};
        0x2::event::emit<UpdateVestingEvent>(v0);
    }

    fun validateClaimFund<T0>(arg0: &mut Pool<T0>, arg1: address) {
        assert!(arg0.state == 2, 1014);
        let (v0, _, v2) = getFundUser<T0>(arg0, arg1);
        assert!(v0 > 0, 1008);
        assert!(v0 > v2, 1009);
    }

    fun validateSetup(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: u128) {
        assert!(arg7 > 0, 1002);
        assert!(arg0 >= 1 && arg0 <= 4, 1004);
        let v0 = if (arg1 >= 0) {
            if (arg1 <= 10000) {
                arg3 >= 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1003);
        if (arg0 == 2 || arg0 == 1) {
            let v1 = if (0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u64>(&arg6)) {
                if (0x1::vector::length<u64>(&arg5) >= 0) {
                    arg4 >= 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 1004);
            let v2 = arg1;
            let v3 = 0;
            while (v3 < 0x1::vector::length<u64>(&arg5)) {
                let v4 = *0x1::vector::borrow<u64>(&arg5, v3);
                v2 = v2 + *0x1::vector::borrow<u64>(&arg6, v3);
                assert!(v4 >= arg2 + arg3 && v4 > 0, 1003);
                v3 = v3 + 1;
            };
            assert!(v2 == 10000, 1004);
        } else {
            let v5 = if (0x1::vector::length<u64>(&arg5) == 0) {
                if (0x1::vector::length<u64>(&arg6) == 0) {
                    if (arg4 >= 0) {
                        arg4 <= 3153600000000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 1004);
        };
    }

    public fun withdrawFundAll<T0>(arg0: &TreasureCap, arg1: &Operation, arg2: &mut Pool<T0>, arg3: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg2.funds_total);
        assert!((v0 as u128) > 0, 1012);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.funds_total, v0, arg4), arg1.operationWallet);
        let v1 = WithdrawFundEvent{
            user        : 0x2::tx_context::sender(arg4),
            fund_amount : (v0 as u128),
        };
        0x2::event::emit<WithdrawFundEvent>(v1);
    }

    public fun withdrawFundAmount<T0>(arg0: &TreasureCap, arg1: &Operation, arg2: &mut Pool<T0>, arg3: u128, arg4: &0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x567d85e05abe70864cfb99cf311f482d4e2a4a26c4fe52363d91717f42352f3e::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 1008);
        let v0 = 0x2::coin::value<T0>(&arg2.funds_total);
        assert!((v0 as u128) >= arg3, 1012);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.funds_total, (arg3 as u64), arg5), arg1.operationWallet);
        let v1 = WithdrawFundEvent{
            user        : 0x2::tx_context::sender(arg5),
            fund_amount : (v0 as u128),
        };
        0x2::event::emit<WithdrawFundEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

