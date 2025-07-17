module 0x3a7ee9dac6d002dceb2b991604be5abe822009feed389b0544bea809fbac2d97::coin_locker {
    struct LockerVault has store, key {
        id: 0x2::object::UID,
    }

    struct CoinLocker has key {
        id: 0x2::object::UID,
        next_lock_id: u64,
        admin: address,
        pending_admin: 0x1::option::Option<address>,
        fee_receiver: address,
        vaults: LockerVault,
        locks: 0x2::table::Table<u64, LockInfo>,
        user_locks: 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>,
        coin_locks: 0x2::table::Table<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>,
        fees: 0x2::vec_map::VecMap<vector<u8>, FeeStruct>,
    }

    struct LockInfo has drop, store {
        lock_id: u64,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        start_time: u64,
        end_time: u64,
        cycle: u64,
        tge_bps: u64,
        cycle_bps: u64,
        unlocked_amount: u64,
        fee_name: 0x1::ascii::String,
    }

    struct FeeStruct has drop, store {
        name: 0x1::ascii::String,
        lock_fee: u64,
        fee_coin_type: 0x1::ascii::String,
    }

    struct OnAddFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lock_fee: u64,
        fee_coin_type: 0x1::ascii::String,
    }

    struct OnUpdateFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lock_fee: u64,
        fee_coin_type: 0x1::ascii::String,
    }

    struct OnRemoveFeeEvent has copy, drop {
        name: 0x1::ascii::String,
        lock_fee: u64,
        fee_coin_type: 0x1::ascii::String,
    }

    struct OnUpdateFeeReceiverEvent has copy, drop {
        original_receiver: address,
        new_receiver: address,
    }

    struct OnLockEvent has copy, drop {
        lock_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        amount: u64,
        start_time: u64,
        end_time: u64,
    }

    struct OnVestingLockEvent has copy, drop {
        lock_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        amount: u64,
        start_time: u64,
        tge_time: u64,
        cycle: u64,
        tge_bps: u64,
        cycle_bps: u64,
    }

    struct OnUpdateLockEvent has copy, drop {
        lock_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        new_amount: u64,
        new_end_time: u64,
    }

    struct OnTransferLockEvent has copy, drop {
        lock_id: u64,
        current_owner: address,
        pending_owner: address,
    }

    struct OnAcceptLockEvent has copy, drop {
        lock_id: u64,
        original_owner: address,
        new_owner: address,
    }

    struct OnUnlockEvent has copy, drop {
        lock_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct OnVestingUnlockEvent has copy, drop {
        lock_id: u64,
        coin_type: 0x1::ascii::String,
        owner: address,
        amount: u64,
        left: u64,
        timestamp: u64,
    }

    struct OnTransferAdminEvent has copy, drop {
        current_admin: address,
        pending_admin: address,
    }

    struct OnAcceptAdminEvent has copy, drop {
        original_admin: address,
        new_admin: address,
    }

    public entry fun accept_admin(arg0: &mut CoinLocker, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::contains<address>(&arg0.pending_admin, &v0), 6);
        let v1 = OnAcceptAdminEvent{
            original_admin : arg0.admin,
            new_admin      : v0,
        };
        0x2::event::emit<OnAcceptAdminEvent>(v1);
        arg0.admin = v0;
        arg0.pending_admin = 0x1::option::none<address>();
    }

    public entry fun accept_lock(arg0: &mut CoinLocker, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        let v1 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(!0x1::option::is_none<address>(&v1.pending_owner) && 0x1::option::contains<address>(&v1.pending_owner, &v0), 8);
        let v2 = &mut arg0.user_locks;
        remove_user_lock(v2, v1.owner, arg1);
        let v3 = &mut arg0.user_locks;
        add_user_lock(v3, v0, arg1);
        let v4 = OnAcceptLockEvent{
            lock_id        : arg1,
            original_owner : v1.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OnAcceptLockEvent>(v4);
        v1.owner = v0;
        v1.pending_owner = 0x1::option::none<address>();
    }

    fun add_balance_to_vault<T0>(arg0: &mut LockerVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = generate_balance_key<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun add_coin_lock(arg0: &mut 0x2::table::Table<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>, arg1: 0x1::ascii::String, arg2: u64) {
        if (!0x2::table::contains<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0, arg1)) {
            0x2::table::add<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0, arg1, 0x2::vec_set::empty<u64>());
        };
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (!0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::insert<u64>(v0, arg2);
        };
    }

    public entry fun add_or_update_fee<T0>(arg0: &mut CoinLocker, arg1: 0x1::ascii::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 5);
        let v0 = &mut arg0.fees;
        add_or_update_fee_internal(v0, arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    fun add_or_update_fee_internal(arg0: &mut 0x2::vec_map::VecMap<vector<u8>, FeeStruct>, arg1: 0x1::ascii::String, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        if (0x2::vec_map::contains<vector<u8>, FeeStruct>(arg0, &v0)) {
            let v1 = 0x2::vec_map::get_mut<vector<u8>, FeeStruct>(arg0, &v0);
            v1.lock_fee = arg2;
            v1.fee_coin_type = arg3;
            let v2 = OnUpdateFeeEvent{
                name          : arg1,
                lock_fee      : arg2,
                fee_coin_type : arg3,
            };
            0x2::event::emit<OnUpdateFeeEvent>(v2);
        } else {
            let v3 = FeeStruct{
                name          : arg1,
                lock_fee      : arg2,
                fee_coin_type : arg3,
            };
            0x2::vec_map::insert<vector<u8>, FeeStruct>(arg0, v0, v3);
            let v4 = OnAddFeeEvent{
                name          : arg1,
                lock_fee      : arg2,
                fee_coin_type : arg3,
            };
            0x2::event::emit<OnAddFeeEvent>(v4);
        };
    }

    fun add_user_lock(arg0: &mut 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1, 0x2::vec_set::empty<u64>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (!0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::insert<u64>(v0, arg2);
        };
    }

    fun create_lock<T0>(arg0: &mut CoinLocker, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = arg0.next_lock_id;
        arg0.next_lock_id = arg0.next_lock_id + 1;
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = &mut arg0.vaults;
        add_balance_to_vault<T0>(v3, arg1);
        let v4 = LockInfo{
            lock_id         : v1,
            owner           : arg3,
            pending_owner   : 0x1::option::none<address>(),
            coin_type       : v2,
            amount          : v0,
            start_time      : arg5,
            end_time        : arg4,
            cycle           : 0,
            tge_bps         : 0,
            cycle_bps       : 0,
            unlocked_amount : 0,
            fee_name        : arg2,
        };
        0x2::table::add<u64, LockInfo>(&mut arg0.locks, v1, v4);
        let v5 = &mut arg0.user_locks;
        add_user_lock(v5, arg3, v1);
        let v6 = &mut arg0.coin_locks;
        add_coin_lock(v6, v2, v1);
        let v7 = OnLockEvent{
            lock_id    : v1,
            coin_type  : v2,
            owner      : arg3,
            amount     : v0,
            start_time : arg5,
            end_time   : arg4,
        };
        0x2::event::emit<OnLockEvent>(v7);
    }

    fun create_vesting_lock<T0>(arg0: &mut CoinLocker, arg1: 0x2::balance::Balance<T0>, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = arg0.next_lock_id;
        arg0.next_lock_id = arg0.next_lock_id + 1;
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = &mut arg0.vaults;
        add_balance_to_vault<T0>(v2, arg1);
        let v3 = LockInfo{
            lock_id         : v0,
            owner           : arg3,
            pending_owner   : 0x1::option::none<address>(),
            coin_type       : v1,
            amount          : arg4,
            start_time      : arg9,
            end_time        : arg5,
            cycle           : arg6,
            tge_bps         : arg7,
            cycle_bps       : arg8,
            unlocked_amount : 0,
            fee_name        : arg2,
        };
        0x2::table::add<u64, LockInfo>(&mut arg0.locks, v0, v3);
        let v4 = &mut arg0.user_locks;
        add_user_lock(v4, arg3, v0);
        let v5 = &mut arg0.coin_locks;
        add_coin_lock(v5, v1, v0);
        let v6 = OnVestingLockEvent{
            lock_id    : v0,
            coin_type  : v1,
            owner      : arg3,
            amount     : arg4,
            start_time : arg9,
            tge_time   : arg5,
            cycle      : arg6,
            tge_bps    : arg7,
            cycle_bps  : arg8,
        };
        0x2::event::emit<OnVestingLockEvent>(v6);
    }

    fun generate_balance_key<T0>() : vector<u8> {
        let v0 = b"balance_";
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    fun get_balance_from_vault<T0>(arg0: &LockerVault) : u64 {
        let v0 = generate_balance_key<T0>();
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public entry fun get_coin_locks<T0>(arg0: &CoinLocker) : 0x2::vec_set::VecSet<u64> {
        *0x2::table::borrow<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(&arg0.coin_locks, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun get_fee(arg0: &CoinLocker, arg1: 0x1::ascii::String) : (0x1::ascii::String, u64, 0x1::ascii::String) {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        if (!0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v0)) {
            let v1 = 0x1::ascii::string(b"DEFAULT");
            v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&v1));
        };
        let v2 = 0x2::vec_map::get<vector<u8>, FeeStruct>(&arg0.fees, &v0);
        (arg1, v2.lock_fee, v2.fee_coin_type)
    }

    public entry fun get_lock_info(arg0: &CoinLocker, arg1: u64) : (address, address, 0x1::ascii::String, u64, u64, u64, u64, u64, u64, u64, 0x1::ascii::String) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        let v0 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        (v0.owner, 0x1::option::get_with_default<address>(&v0.pending_owner, @0x0), v0.coin_type, v0.amount, v0.start_time, v0.end_time, v0.cycle, v0.tge_bps, v0.cycle_bps, v0.unlocked_amount, v0.fee_name)
    }

    public entry fun get_locked_coin_amount<T0>(arg0: &CoinLocker) : u64 {
        get_balance_from_vault<T0>(&arg0.vaults)
    }

    public entry fun get_user_locks(arg0: &CoinLocker, arg1: address) : 0x2::vec_set::VecSet<u64> {
        *0x2::table::borrow<address, 0x2::vec_set::VecSet<u64>>(&arg0.user_locks, arg1)
    }

    public entry fun get_withdrawable_amount(arg0: &CoinLocker, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        withdrawable_amount(0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1), 0x2::clock::timestamp_ms(arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LockerVault{id: 0x2::object::new(arg0)};
        let v1 = CoinLocker{
            id            : 0x2::object::new(arg0),
            next_lock_id  : 1,
            admin         : @0x665e4337f39aad6de7252b16442088cbb5d1b4152fd2820a14d6aa1dfc46abde,
            pending_admin : 0x1::option::none<address>(),
            fee_receiver  : @0x665e4337f39aad6de7252b16442088cbb5d1b4152fd2820a14d6aa1dfc46abde,
            vaults        : v0,
            locks         : 0x2::table::new<u64, LockInfo>(arg0),
            user_locks    : 0x2::table::new<address, 0x2::vec_set::VecSet<u64>>(arg0),
            coin_locks    : 0x2::table::new<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0),
            fees          : 0x2::vec_map::empty<vector<u8>, FeeStruct>(),
        };
        let v2 = &mut v1.fees;
        add_or_update_fee_internal(v2, 0x1::ascii::string(b"DEFAULT"), 120000000, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        0x2::transfer::share_object<CoinLocker>(v1);
    }

    public fun is_supported_fee_name(arg0: &CoinLocker, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v0)
    }

    public entry fun lock<T0, T1>(arg0: &mut CoinLocker, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 > v0, 3);
        assert!(0x2::coin::value<T0>(&arg1) >= arg6, 2);
        let v1 = take_fee<T1>(arg0, arg2, arg3, arg8);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1), 0x2::tx_context::sender(arg8));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v1);
        };
        if (0x2::coin::value<T0>(&arg1) == arg6) {
            create_lock<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg3, arg4, arg5, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg8));
            create_lock<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg6, arg8)), arg3, arg4, arg5, v0);
        };
    }

    fun normal_unlock<T0>(arg0: &mut CoinLocker, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        let v1 = v0.owner;
        let v2 = v0.coin_type;
        let v3 = &mut arg0.vaults;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(remove_balance_from_vault<T0>(v3, arg2, arg4), v1);
        let v4 = &mut arg0.user_locks;
        remove_user_lock(v4, v1, arg1);
        let v5 = &mut arg0.coin_locks;
        remove_coin_lock(v5, v2, arg1);
        0x2::table::remove<u64, LockInfo>(&mut arg0.locks, arg1);
        let v6 = OnUnlockEvent{
            lock_id   : arg1,
            coin_type : v2,
            owner     : v1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<OnUnlockEvent>(v6);
    }

    fun remove_balance_from_vault<T0>(arg0: &mut LockerVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = generate_balance_key<T0>();
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 16);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    fun remove_coin_lock(arg0: &mut 0x2::table::Table<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>, arg1: 0x1::ascii::String, arg2: u64) {
        assert!(0x2::table::contains<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::remove<u64>(v0, &arg2);
        };
    }

    public entry fun remove_fee(arg0: &mut CoinLocker, arg1: 0x1::ascii::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        let v0 = &mut arg0.fees;
        remove_fee_internal(v0, arg1);
    }

    fun remove_fee_internal(arg0: &mut 0x2::vec_map::VecMap<vector<u8>, FeeStruct>, arg1: 0x1::ascii::String) {
        assert!(arg1 != 0x1::ascii::string(b"DEFAULT"), 13);
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        assert!(0x2::vec_map::contains<vector<u8>, FeeStruct>(arg0, &v0), 12);
        let (_, v2) = 0x2::vec_map::remove<vector<u8>, FeeStruct>(arg0, &v0);
        let v3 = v2;
        let v4 = OnRemoveFeeEvent{
            name          : arg1,
            lock_fee      : v3.lock_fee,
            fee_coin_type : v3.fee_coin_type,
        };
        0x2::event::emit<OnRemoveFeeEvent>(v4);
    }

    fun remove_user_lock(arg0: &mut 0x2::table::Table<address, 0x2::vec_set::VecSet<u64>>, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1), 7);
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<u64>>(arg0, arg1);
        if (0x2::vec_set::contains<u64>(v0, &arg2)) {
            0x2::vec_set::remove<u64>(v0, &arg2);
        };
    }

    fun take_fee<T0>(arg0: &CoinLocker, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg2));
        assert!(0x2::vec_map::contains<vector<u8>, FeeStruct>(&arg0.fees, &v0), 12);
        let v1 = 0x2::vec_map::get<vector<u8>, FeeStruct>(&arg0.fees, &v0);
        let v2 = v1.fee_coin_type;
        let v3 = 0x1::type_name::get<T0>();
        assert!(&v2 == 0x1::type_name::borrow_string(&v3), 14);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 >= v1.lock_fee, 15);
        if (v4 == v1.lock_fee) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.fee_receiver);
            0x1::option::none<0x2::coin::Coin<T0>>()
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1.lock_fee, arg3), arg0.fee_receiver);
            0x1::option::some<0x2::coin::Coin<T0>>(arg1)
        }
    }

    public entry fun transfer_admin(arg0: &mut CoinLocker, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin, 5);
        arg0.pending_admin = 0x1::option::some<address>(arg1);
        let v1 = OnTransferAdminEvent{
            current_admin : v0,
            pending_admin : arg1,
        };
        0x2::event::emit<OnTransferAdminEvent>(v1);
    }

    public entry fun transfer_lock(arg0: &mut CoinLocker, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        let v0 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0.owner == v1, 7);
        v0.pending_owner = 0x1::option::some<address>(arg2);
        let v2 = OnTransferLockEvent{
            lock_id       : arg1,
            current_owner : v1,
            pending_owner : arg2,
        };
        0x2::event::emit<OnTransferLockEvent>(v2);
    }

    public entry fun unlock<T0>(arg0: &mut CoinLocker, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        let v0 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        assert!(v0.unlocked_amount < v0.amount, 11);
        assert!(v0.coin_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 > v0.end_time, 9);
        let v2 = withdrawable_amount(v0, v1);
        assert!(v2 > 0 && v2 + v0.unlocked_amount <= v0.amount, 10);
        assert!(v2 <= get_balance_from_vault<T0>(&arg0.vaults), 16);
        if (v0.tge_bps > 0) {
            vesting_unlock<T0>(arg0, arg1, v2, v1, arg3);
        } else {
            normal_unlock<T0>(arg0, arg1, v2, v1, arg3);
        };
    }

    public entry fun update_fee_receiver(arg0: &mut CoinLocker, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 5);
        let v0 = OnUpdateFeeReceiverEvent{
            original_receiver : arg0.fee_receiver,
            new_receiver      : arg1,
        };
        0x2::event::emit<OnUpdateFeeReceiverEvent>(v0);
        arg0.fee_receiver = arg1;
    }

    public entry fun update_lock<T0>(arg0: &mut CoinLocker, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<u64, LockInfo>(&arg0.locks, arg1), 4);
        let v1 = 0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1);
        assert!(v1.owner == v0, 7);
        assert!(v1.unlocked_amount == 0, 11);
        assert!(arg4 > v1.end_time && arg4 > 0x2::clock::timestamp_ms(arg5), 18);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(arg3 > 0 && arg3 <= v2, 2);
        if (arg3 == v2) {
            let v3 = &mut arg0.vaults;
            add_balance_to_vault<T0>(v3, 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg6));
            let v4 = &mut arg0.vaults;
            add_balance_to_vault<T0>(v4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg6)));
        };
        v1.amount = v1.amount + arg3;
        v1.end_time = arg4;
        let v5 = OnUpdateLockEvent{
            lock_id      : arg1,
            coin_type    : v1.coin_type,
            owner        : v0,
            new_amount   : v1.amount,
            new_end_time : arg4,
        };
        0x2::event::emit<OnUpdateLockEvent>(v5);
    }

    public entry fun vesting_lock<T0, T1>(arg0: &mut CoinLocker, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg6 > v0, 3);
        assert!(0x2::coin::value<T0>(&arg1) >= arg5, 2);
        let v1 = if (arg8 > 0) {
            if (arg9 > 0) {
                arg8 + arg9 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 17);
        let v2 = take_fee<T1>(arg0, arg2, arg3, arg11);
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v2), 0x2::tx_context::sender(arg11));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(v2);
        };
        if (0x2::coin::value<T0>(&arg1) == arg5) {
            create_vesting_lock<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg11));
            create_vesting_lock<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg5, arg11)), arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0);
        };
    }

    fun vesting_unlock<T0>(arg0: &mut CoinLocker, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u64, LockInfo>(&arg0.locks, arg1);
        let v1 = v0.owner;
        let v2 = v0.coin_type;
        let v3 = v0.amount;
        let v4 = v0.unlocked_amount;
        let v5 = &mut arg0.vaults;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(remove_balance_from_vault<T0>(v5, arg2, arg4), v1);
        let v6 = v4 + arg2;
        let v7 = v3 - v6;
        if (v7 == 0) {
            let v8 = &mut arg0.user_locks;
            remove_user_lock(v8, v1, arg1);
            let v9 = &mut arg0.coin_locks;
            remove_coin_lock(v9, v2, arg1);
            0x2::table::remove<u64, LockInfo>(&mut arg0.locks, arg1);
        } else {
            0x2::table::borrow_mut<u64, LockInfo>(&mut arg0.locks, arg1).unlocked_amount = v6;
        };
        let v10 = OnVestingUnlockEvent{
            lock_id   : arg1,
            coin_type : v2,
            owner     : v1,
            amount    : arg2,
            left      : v7,
            timestamp : arg3,
        };
        0x2::event::emit<OnVestingUnlockEvent>(v10);
    }

    fun withdrawable_amount(arg0: &LockInfo, arg1: u64) : u64 {
        let v0 = arg0.amount;
        let v1 = arg0.unlocked_amount;
        if (v0 == 0) {
            return 0
        };
        if (v1 >= v0) {
            return 0
        };
        if (arg1 < arg0.end_time) {
            return 0
        };
        if (arg0.cycle == 0) {
            return v0 - v1
        };
        let v2 = v0 * arg0.tge_bps / 10000 + (arg1 - arg0.end_time) / arg0.cycle * v0 * arg0.cycle_bps / 10000;
        if (v2 > v0) {
            v0 - v1
        } else {
            v2 - v1
        }
    }

    // decompiled from Move bytecode v6
}

