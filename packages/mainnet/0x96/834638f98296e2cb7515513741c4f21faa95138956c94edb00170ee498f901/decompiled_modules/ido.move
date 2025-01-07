module 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::ido {
    struct IDO has drop {
        dummy_field: bool,
    }

    struct Admincap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProviderCap has store, key {
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

    struct Order has store {
        buyer: address,
        coin_amount: u64,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: address,
        type_name_coin: 0x1::type_name::TypeName,
        start_time: u64,
        end_time: u64,
        targeted_raise: u128,
    }

    struct UpdateTimeEvent has copy, drop {
        pool_id: address,
        start_time: u64,
        end_time: u64,
    }

    struct UpdateTargetedRaiseEvent has copy, drop {
        pool_id: address,
        targeted_raise: u128,
    }

    struct UpdateDefaultMaxAllocateEvent has copy, drop {
        pool_id: address,
        default_max_allocate: u128,
    }

    struct UpdateUseWhitelistEvent has copy, drop {
        pool_id: address,
        use_whitelist: bool,
    }

    struct UpdateConfigMaxInTurnEvent has copy, drop {
        pool_id: address,
        enable_max_in_turn: bool,
        max_in_turn: u128,
    }

    struct UpdatePoolStatusEvent has copy, drop {
        pool_id: address,
        new_status: u8,
    }

    struct AddMaxAllocateEvent has copy, drop {
        pool_id: address,
        users: vector<address>,
        max_allocates: vector<u64>,
    }

    struct RemoveMaxAllocateEvent has copy, drop {
        pool_id: address,
        users: vector<address>,
    }

    struct AddWhiteListEvent has copy, drop {
        pool_id: address,
        users: vector<address>,
    }

    struct RemoveWhiteListEvent has copy, drop {
        pool_id: address,
        users: vector<address>,
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

    struct BuyEvent has copy, drop {
        pool_id: address,
        buyer: address,
        amount: u64,
        total_bought: u128,
        total_raised: u128,
    }

    struct BuyByTokenFreeFailedEvent has copy, drop {
        pool_id: address,
        buyer: address,
        amount: u128,
        total_bought: u128,
        total_raised: u128,
        buy_req: vector<u8>,
        buy_fail_reason: u64,
    }

    struct BuyByTokenFreeEvent has copy, drop {
        pool_id: address,
        buyer: address,
        amount: u128,
        total_bought: u128,
        total_raised: u128,
        buy_req: vector<u8>,
    }

    struct WithdrawFundEvent has copy, drop {
        pool_id: address,
        operationWallet: address,
        amount: u128,
    }

    struct WithdrawFundEventAll has copy, drop {
        pool_id: address,
        operationWallet: address,
        total_raised: u128,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        type_name_coin: 0x1::type_name::TypeName,
        state: u8,
        start_time: u64,
        end_time: u64,
        total_raised: 0x2::coin::Coin<T0>,
        targeted_raise: u128,
        default_max_allocate: u128,
        order_book: 0x2::table::Table<address, Order>,
        max_allocations: 0x2::table::Table<address, u64>,
        whitelist: 0x2::table::Table<address, bool>,
        use_whitelist: bool,
        enable_max_in_turn: bool,
        max_in_turn: u128,
    }

    public fun addMaxAllocations<T0>(arg0: &ManagerCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut Pool<T0>, arg4: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg4, 1);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1004);
        let v0 = &mut arg3.max_allocations;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v3 > 0, 1005);
            if (0x2::table::contains<address, u64>(v0, v2)) {
                0x2::table::remove<address, u64>(v0, v2);
            };
            0x2::table::add<address, u64>(v0, v2, v3);
            v1 = v1 + 1;
        };
        let v4 = AddMaxAllocateEvent{
            pool_id       : 0x2::object::id_address<Pool<T0>>(arg3),
            users         : arg1,
            max_allocates : arg2,
        };
        0x2::event::emit<AddMaxAllocateEvent>(v4);
    }

    public fun addMemberInVault(arg0: &Admincap, arg1: address, arg2: &mut Vault, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(!0x1::option::is_some<address>(&arg2.member), 1004);
        0x1::option::fill<address>(&mut arg2.member, arg1);
        let v0 = AddMemberInVaultEvent{member: arg1};
        0x2::event::emit<AddMemberInVaultEvent>(v0);
    }

    public fun addWhitelist<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: vector<address>, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg1.use_whitelist, 1006);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1007);
        let v0 = &mut arg1.whitelist;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(!0x2::table::contains<address, bool>(v0, v3), 1008);
            0x2::table::add<address, bool>(v0, v3, true);
            0x1::vector::push_back<address>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = AddWhiteListEvent{
            pool_id : 0x2::object::id_address<Pool<T0>>(arg1),
            users   : v1,
        };
        0x2::event::emit<AddWhiteListEvent>(v4);
    }

    public fun buy<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        validatorBuy<T0>(arg0, v0, arg2, arg4);
        0x2::coin::join<T0>(&mut arg0.total_raised, arg1);
        if ((0x2::coin::value<T0>(&arg0.total_raised) as u128) >= arg0.targeted_raise) {
            arg0.state = 4;
        };
        let v1 = 0x2::object::id_address<Pool<T0>>(arg0);
        let v2 = getFundUser<T0>(arg0, 0x2::tx_context::sender(arg4));
        let v3 = BuyEvent{
            pool_id      : v1,
            buyer        : 0x2::tx_context::sender(arg4),
            amount       : v0,
            total_bought : (v2 as u128),
            total_raised : (0x2::coin::value<T0>(&arg0.total_raised) as u128),
        };
        0x2::event::emit<BuyEvent>(v3);
    }

    public fun buyByTokenFree<T0>(arg0: &mut Pool<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: 0x2::coin::Coin<T0>, arg5: &ProviderCap, arg6: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg6, 1);
        validatorbuyByTokenFree<T0>(arg0, arg7, arg1, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg2, v0);
            let v3 = if (0x2::table::contains<address, Order>(&arg0.order_book, v1)) {
                0x2::table::borrow_mut<address, Order>(&mut arg0.order_book, v1)
            } else {
                let v4 = Order{
                    buyer       : v1,
                    coin_amount : 0,
                };
                0x2::table::add<address, Order>(&mut arg0.order_book, v1, v4);
                0x2::table::borrow_mut<address, Order>(&mut arg0.order_book, v1)
            };
            let v5 = v3.coin_amount + v2;
            let v6 = get_max_allocate(v1, &arg0.max_allocations);
            let v7 = if (arg0.state != 2) {
                true
            } else if (arg0.start_time > 0x2::clock::timestamp_ms(arg7)) {
                true
            } else if (arg0.end_time < 0x2::clock::timestamp_ms(arg7)) {
                true
            } else {
                v5 > v6 && arg0.default_max_allocate < (v5 as u128)
            };
            if (v7) {
                let v8 = BuyByTokenFreeFailedEvent{
                    pool_id         : 0x2::object::id_address<Pool<T0>>(arg0),
                    buyer           : v1,
                    amount          : (v2 as u128),
                    total_bought    : (v5 as u128),
                    total_raised    : (0x2::coin::value<T0>(&arg0.total_raised) as u128),
                    buy_req         : *0x1::vector::borrow<vector<u8>>(&arg3, v0),
                    buy_fail_reason : checkBuyFailReason<T0>(arg0, v1, (v5 as u128), arg7),
                };
                0x2::event::emit<BuyByTokenFreeFailedEvent>(v8);
            } else {
                assert!(v6 >= v5 || arg0.default_max_allocate >= (v5 as u128), 1022);
                v3.coin_amount = v5;
                0x2::coin::join<T0>(&mut arg0.total_raised, 0x2::coin::split<T0>(&mut arg4, v2, arg8));
                if ((0x2::coin::value<T0>(&arg0.total_raised) as u128) >= arg0.targeted_raise) {
                    arg0.state = 4;
                };
                let v9 = BuyByTokenFreeEvent{
                    pool_id      : 0x2::object::id_address<Pool<T0>>(arg0),
                    buyer        : v1,
                    amount       : (v2 as u128),
                    total_bought : (v5 as u128),
                    total_raised : (0x2::coin::value<T0>(&arg0.total_raised) as u128),
                    buy_req      : *0x1::vector::borrow<vector<u8>>(&arg3, v0),
                };
                0x2::event::emit<BuyByTokenFreeEvent>(v9);
            };
            v0 = v0 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, 0x2::tx_context::sender(arg8));
    }

    public fun changeMemberInVault(arg0: &Admincap, arg1: address, arg2: &mut Vault, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(0x1::option::is_some<address>(&arg2.member) && arg1 != *0x1::option::borrow<address>(&arg2.member), 1004);
        0x1::option::swap<address>(&mut arg2.member, arg1);
        let v0 = ChangeMemberInVaultEvent{new_member: arg1};
        0x2::event::emit<ChangeMemberInVaultEvent>(v0);
    }

    public fun changeOperationWallet(arg0: &mut Operation, arg1: &Vault, arg2: address, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg2 != arg0.operationWallet, 1004);
        assert!(0x1::option::is_some<address>(&arg1.member) && *0x1::option::borrow<address>(&arg1.member) == 0x2::tx_context::sender(arg4), 1009);
        assert!(arg0.operationWallet == 0x2::tx_context::sender(arg4), 1009);
        arg0.operationWallet = arg2;
        let v0 = ChangeOperationWalletEvent{new_operation_wallet: arg2};
        0x2::event::emit<ChangeOperationWalletEvent>(v0);
    }

    public fun changeStatus<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: u8, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg2 > 0 && arg2 <= 4, 1004);
        arg1.state = arg2;
        let v0 = UpdatePoolStatusEvent{
            pool_id    : 0x2::object::id_address<Pool<T0>>(arg1),
            new_status : arg2,
        };
        0x2::event::emit<UpdatePoolStatusEvent>(v0);
    }

    public fun checkBuyFailReason<T0>(arg0: &Pool<T0>, arg1: address, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.state != 2 || v0 < arg0.start_time) {
            return 1020
        };
        if (v0 >= arg0.end_time) {
            return 1021
        };
        if (arg2 > (get_max_allocate(arg1, &arg0.max_allocations) as u128) && arg0.default_max_allocate < arg2) {
            return 1022
        };
        1023
    }

    public fun configMaxInTurn<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: bool, arg3: u128, arg4: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg4, 1);
        assert!(arg2 != arg1.enable_max_in_turn && arg3 > 0, 1004);
        arg1.enable_max_in_turn = arg2;
        arg1.max_in_turn = arg3;
        let v0 = UpdateConfigMaxInTurnEvent{
            pool_id            : 0x2::object::id_address<Pool<T0>>(arg1),
            enable_max_in_turn : arg1.enable_max_in_turn,
            max_in_turn        : arg1.max_in_turn,
        };
        0x2::event::emit<UpdateConfigMaxInTurnEvent>(v0);
    }

    public fun createPool<T0>(arg0: &Admincap, arg1: vector<u8>, arg2: u128, arg3: u64, arg4: u64, arg5: u128, arg6: bool, arg7: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg7, 1);
        validatorCreatePool(arg2, arg3, arg4, arg5, arg8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Pool<T0>{
            id                   : 0x2::object::new(arg9),
            name                 : arg1,
            type_name_coin       : v0,
            state                : 1,
            start_time           : arg3,
            end_time             : arg4,
            total_raised         : 0x2::coin::zero<T0>(arg9),
            targeted_raise       : arg2,
            default_max_allocate : arg5,
            order_book           : 0x2::table::new<address, Order>(arg9),
            max_allocations      : 0x2::table::new<address, u64>(arg9),
            whitelist            : 0x2::table::new<address, bool>(arg9),
            use_whitelist        : arg6,
            enable_max_in_turn   : false,
            max_in_turn          : 1000000000000000000000,
        };
        let v2 = CreatePoolEvent{
            pool_id        : 0x2::object::id_address<Pool<T0>>(&v1),
            type_name_coin : v0,
            start_time     : arg3,
            end_time       : arg4,
            targeted_raise : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v2);
        0x2::transfer::share_object<Pool<T0>>(v1);
    }

    public fun getFundUser<T0>(arg0: &mut Pool<T0>, arg1: address) : u64 {
        0x2::table::borrow_mut<address, Order>(&mut arg0.order_book, arg1).coin_amount
    }

    public fun get_max_allocate(arg0: address, arg1: &0x2::table::Table<address, u64>) : u64 {
        if (0x2::table::contains<address, u64>(arg1, arg0)) {
            *0x2::table::borrow<address, u64>(arg1, arg0)
        } else {
            0
        }
    }

    fun init(arg0: IDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Admincap{id: 0x2::object::new(arg1)};
        let v1 = TreasureCap{id: 0x2::object::new(arg1)};
        let v2 = ProviderCap{id: 0x2::object::new(arg1)};
        let v3 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Admincap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasureCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ProviderCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ManagerCap>(v3, 0x2::tx_context::sender(arg1));
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::cap_vault::createVault<Admincap>(arg1);
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::cap_vault::createVault<TreasureCap>(arg1);
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::cap_vault::createVault<ProviderCap>(arg1);
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::cap_vault::createVault<ManagerCap>(arg1);
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

    public fun removeMaxAllocations<T0>(arg0: &ManagerCap, arg1: vector<address>, arg2: &mut Pool<T0>, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        let v0 = &mut arg2.max_allocations;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (0x2::table::contains<address, u64>(v0, v2)) {
                0x2::table::remove<address, u64>(v0, v2);
            };
            v1 = v1 + 1;
        };
        let v3 = RemoveMaxAllocateEvent{
            pool_id : 0x2::object::id_address<Pool<T0>>(arg2),
            users   : arg1,
        };
        0x2::event::emit<RemoveMaxAllocateEvent>(v3);
    }

    public fun removeWhitelist<T0>(arg0: &ManagerCap, arg1: &mut Pool<T0>, arg2: vector<address>, arg3: &mut 0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg1.use_whitelist, 1006);
        assert!(0x1::vector::length<address>(&arg2) > 0, 1007);
        let v0 = &mut arg1.whitelist;
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = 0x1::vector::pop_back<address>(&mut arg2);
            assert!(0x2::table::contains<address, bool>(v0, v3), 1008);
            0x2::table::remove<address, bool>(v0, v3);
            0x1::vector::push_back<address>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = RemoveWhiteListEvent{
            pool_id : 0x2::object::id_address<Pool<T0>>(arg1),
            users   : v1,
        };
        0x2::event::emit<RemoveWhiteListEvent>(v4);
    }

    public fun updateDefaultMaxAllocate<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: u128, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 1004);
        arg1.default_max_allocate = arg2;
        let v0 = UpdateDefaultMaxAllocateEvent{
            pool_id              : 0x2::object::id_address<Pool<T0>>(arg1),
            default_max_allocate : arg1.default_max_allocate,
        };
        0x2::event::emit<UpdateDefaultMaxAllocateEvent>(v0);
    }

    public fun updateTargetedRaise<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: u128, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 1004);
        arg1.targeted_raise = arg2;
        let v0 = UpdateTargetedRaiseEvent{
            pool_id        : 0x2::object::id_address<Pool<T0>>(arg1),
            targeted_raise : arg1.targeted_raise,
        };
        0x2::event::emit<UpdateTargetedRaiseEvent>(v0);
    }

    public fun updateTime<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg5, 1);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4) && arg3 > arg2, 1001);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        let v0 = UpdateTimeEvent{
            pool_id    : 0x2::object::id_address<Pool<T0>>(arg1),
            start_time : arg2,
            end_time   : arg3,
        };
        0x2::event::emit<UpdateTimeEvent>(v0);
    }

    public fun updateUseWhitelist<T0>(arg0: &Admincap, arg1: &mut Pool<T0>, arg2: bool, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        assert!(arg2 != arg1.use_whitelist, 1004);
        arg1.use_whitelist = arg2;
        let v0 = UpdateUseWhitelistEvent{
            pool_id       : 0x2::object::id_address<Pool<T0>>(arg1),
            use_whitelist : arg1.use_whitelist,
        };
        0x2::event::emit<UpdateUseWhitelistEvent>(v0);
    }

    fun validatorBuy<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 1010);
        assert!(arg0.state == 2, 1020);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.start_time && 0x2::clock::timestamp_ms(arg2) < arg0.end_time, 1001);
        assert!(!arg0.enable_max_in_turn || arg0.enable_max_in_turn && arg0.max_in_turn >= (arg1 as u128), 1011);
        if (arg0.use_whitelist) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 1006);
        };
        let v1 = if (0x2::table::contains<address, Order>(&arg0.order_book, v0)) {
            0x2::table::borrow_mut<address, Order>(&mut arg0.order_book, v0)
        } else {
            let v2 = Order{
                buyer       : v0,
                coin_amount : 0,
            };
            0x2::table::add<address, Order>(&mut arg0.order_book, v0, v2);
            0x2::table::borrow_mut<address, Order>(&mut arg0.order_book, v0)
        };
        let v3 = v1.coin_amount + arg1;
        assert!(v3 <= get_max_allocate(v0, &arg0.max_allocations) || arg0.default_max_allocate >= (v3 as u128), 1022);
        v1.coin_amount = v3;
    }

    fun validatorCreatePool(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock) {
        assert!(arg0 > 0, 1002);
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4) && arg2 > arg1, 1001);
        assert!(arg3 > 0, 1003);
    }

    fun validatorbuyByTokenFree<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: vector<u64>) {
        assert!(arg0.state == 2, 1020);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_time && v0 < arg0.end_time, 1001);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 1004);
    }

    public fun withdrawFundAll<T0>(arg0: &TreasureCap, arg1: &mut Pool<T0>, arg2: &Operation, arg3: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg1.total_raised);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.total_raised, v0, arg4), arg2.operationWallet);
        let v1 = WithdrawFundEventAll{
            pool_id         : 0x2::object::id_address<Pool<T0>>(arg1),
            operationWallet : arg2.operationWallet,
            total_raised    : (v0 as u128),
        };
        0x2::event::emit<WithdrawFundEventAll>(v1);
    }

    public fun withdrawFundAmount<T0>(arg0: &TreasureCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &Operation, arg4: &0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x96834638f98296e2cb7515513741c4f21faa95138956c94edb00170ee498f901::version::checkVersion(arg4, 1);
        assert!(0x2::coin::value<T0>(&arg1.total_raised) >= arg2, 1010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.total_raised, arg2, arg5), arg3.operationWallet);
        let v0 = WithdrawFundEvent{
            pool_id         : 0x2::object::id_address<Pool<T0>>(arg1),
            operationWallet : arg3.operationWallet,
            amount          : (arg2 as u128),
        };
        0x2::event::emit<WithdrawFundEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

