module 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::vault {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PreUnlockVesting has store {
        amount: u64,
        start_time: u64,
        vesting_period: u64,
        claimed_amount: u64,
    }

    struct VoteEscrowedToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        base_token: 0x1::type_name::TypeName,
        locked_amount: u64,
        max_voting_power: u64,
        lock_start_time: u64,
        lock_period: u64,
        lock_end_time: u64,
        is_active: bool,
        is_always_max_power: bool,
        pre_unlock_vesting: PreUnlockVesting,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct VeTokenVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        enabled: bool,
        reward_manager: address,
        ve_token_count: u64,
        total_locked_balance: 0x2::balance::Balance<T0>,
        total_penalty_balance: 0x2::balance::Balance<T0>,
        total_max_voting_power: u64,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    struct NAVXLocked has copy, drop {
        nft_id: address,
        amount: u64,
        lock_start_time: u64,
        lock_end_time: u64,
        max_voting_power: u64,
        is_always_max_power: bool,
    }

    struct NAVXUnlocked has copy, drop {
        nft_id: address,
        amount: u64,
    }

    struct OwnerCapCreated has copy, drop {
        sender: address,
        owner_cap: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
    }

    struct LockPeriodExtended has copy, drop {
        nft_id: address,
        new_period: u64,
    }

    struct PreUnlockStarted has copy, drop {
        nft_id: address,
        vesting_amount: u64,
        vesting_period: u64,
    }

    struct PreUnlockClaimed has copy, drop {
        nft_id: address,
        claimed_amount: u64,
    }

    struct VeTokenMerged has copy, drop {
        nft_ids: vector<address>,
        new_nft_id: address,
        new_locked_amount: u64,
        new_lock_period: u64,
    }

    struct PenaltyAmountClaimed has copy, drop {
        amount: u64,
    }

    struct SwitchedToAlwaysMaxPower has copy, drop {
        nft_id: address,
    }

    struct SwitchedToNormal has copy, drop {
        nft_id: address,
    }

    struct VaultDisabled has copy, drop {
        vault_id: address,
    }

    struct VaultEnabled has copy, drop {
        vault_id: address,
    }

    struct OwnerCapDeleted has copy, drop {
        owner_cap_id: address,
    }

    struct VaultUpgraded has copy, drop {
        vault_id: address,
        version: u64,
    }

    struct RewardManagerSet has copy, drop {
        vault_id: address,
        reward_manager_id: address,
    }

    public fun check_already_pre_unlock_vesting<T0>(arg0: &VoteEscrowedToken<T0>) {
        assert!(arg0.pre_unlock_vesting.amount == 0, 1005);
    }

    public fun check_enabled(arg0: bool) {
        assert!(arg0, 1011);
    }

    public fun check_lock_period(arg0: u64) {
        assert!(arg0 >= 86400000 && arg0 <= 63072000000, 1001);
    }

    public fun check_nft_active<T0>(arg0: &VoteEscrowedToken<T0>) {
        assert!(arg0.is_active, 1003);
    }

    public fun check_version(arg0: u64) {
        assert!(arg0 == 0, 1008);
    }

    public fun check_vesting_period<T0>(arg0: &VoteEscrowedToken<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 <= 31536000000, 1002);
        assert!(arg2 <= (arg0.lock_end_time - arg1) / 2, 1002);
    }

    public(friend) fun claim_penalty_amount<T0>(arg0: &OwnerCap, arg1: &mut VeTokenVault<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = PenaltyAmountClaimed{amount: arg2};
        0x2::event::emit<PenaltyAmountClaimed>(v0);
        0x2::balance::split<T0>(&mut arg1.total_penalty_balance, arg2)
    }

    public(friend) fun claim_pre_unlock<T0>(arg0: &mut VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        let (v0, v1) = update_pre_unlock<T0>(arg1, arg2);
        assert!(v0 > 0, 1006);
        arg1.locked_amount = arg1.locked_amount - v0;
        arg1.max_voting_power = (((arg1.max_voting_power as u128) * (arg1.locked_amount as u128) * (1000000 as u128) / (arg1.locked_amount as u128) / (1000000 as u128)) as u64);
        arg0.total_max_voting_power = arg0.total_max_voting_power - arg1.max_voting_power - arg1.max_voting_power;
        if (v1) {
            arg1.is_active = false;
        };
        let v2 = PreUnlockClaimed{
            nft_id         : 0x2::object::uid_to_address(&arg1.id),
            claimed_amount : v0,
        };
        0x2::event::emit<PreUnlockClaimed>(v2);
        0x2::balance::split<T0>(&mut arg0.total_locked_balance, v0)
    }

    public(friend) fun create_owner_cap(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = OwnerCapCreated{
            sender    : 0x2::tx_context::sender(arg0),
            owner_cap : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<OwnerCapCreated>(v1);
        v0
    }

    public(friend) fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeTokenVault<T0>{
            id                     : 0x2::object::new(arg0),
            version                : 0,
            enabled                : true,
            reward_manager         : 0x2::address::from_u256(0),
            ve_token_count         : 0,
            total_locked_balance   : 0x2::balance::zero<T0>(),
            total_penalty_balance  : 0x2::balance::zero<T0>(),
            total_max_voting_power : 0,
        };
        let v1 = VaultCreated{vault_id: 0x2::object::uid_to_address(&v0.id)};
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::public_share_object<VeTokenVault<T0>>(v0);
    }

    public(friend) fun delete_owner_cap(arg0: OwnerCap) {
        let OwnerCap { id: v0 } = arg0;
        let v1 = OwnerCapDeleted{owner_cap_id: 0x2::object::uid_to_address(&v0)};
        0x2::event::emit<OwnerCapDeleted>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun disable_vault<T0>(arg0: &mut VeTokenVault<T0>) {
        arg0.enabled = false;
        let v0 = VaultDisabled{vault_id: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<VaultDisabled>(v0);
    }

    public(friend) fun enable_vault<T0>(arg0: &mut VeTokenVault<T0>) {
        arg0.enabled = true;
        let v0 = VaultEnabled{vault_id: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<VaultEnabled>(v0);
    }

    public(friend) fun extend_lock<T0>(arg0: &mut VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        update_nft_lock_start_end_time<T0>(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        check_already_pre_unlock_vesting<T0>(arg1);
        check_nft_active<T0>(arg1);
        check_lock_period(arg3);
        assert!(arg3 > arg1.lock_end_time - v0, 1001);
        arg1.lock_start_time = v0;
        arg1.lock_end_time = v0 + arg3;
        arg1.lock_period = arg3;
        arg1.max_voting_power = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(arg1.locked_amount, arg3);
        arg0.total_max_voting_power = arg0.total_max_voting_power - arg1.max_voting_power + arg1.max_voting_power;
        let v1 = LockPeriodExtended{
            nft_id     : 0x2::object::uid_to_address(&arg1.id),
            new_period : arg3,
        };
        0x2::event::emit<LockPeriodExtended>(v1);
    }

    public(friend) fun get_display_info(arg0: u64) : (0x1::string::String, 0x1::string::String, 0x2::url::Url) {
        let v0 = 0x1::string::utf8(b"Vote-Escrowed NAVX #");
        let v1 = 0x1::string::utf8(b"https://x4rjmmpwhoncvduw.public.blob.vercel-storage.com/lending/veNavx/");
        0x1::string::append(&mut v1, u64_to_string(arg0));
        0x1::string::append(&mut v0, u64_to_string(arg0));
        (v0, 0x1::string::utf8(b"veNAVX represents the vote-escrowed NAVX and has voting power & yield on NAVI Protocol"), 0x2::url::new_unsafe(0x1::string::to_ascii(v1)))
    }

    public(friend) fun get_dynamic_voting_power<T0>(arg0: &VoteEscrowedToken<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.is_always_max_power) {
            arg0.max_voting_power
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            if (v1 >= arg0.lock_end_time) {
                0
            } else {
                (((arg0.max_voting_power as u128) * ((arg0.lock_end_time - v1) as u128) * (1000000 as u128) / ((arg0.lock_end_time - arg0.lock_start_time) as u128) / (1000000 as u128)) as u64)
            }
        }
    }

    public fun get_nft_info<T0>(arg0: &VoteEscrowedToken<T0>) : (address, 0x1::type_name::TypeName, u64, u64, u64, u64, u64, bool, bool, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.base_token, arg0.locked_amount, arg0.max_voting_power, arg0.lock_start_time, arg0.lock_period, arg0.lock_end_time, arg0.is_active, arg0.is_always_max_power, arg0.pre_unlock_vesting.amount, arg0.pre_unlock_vesting.start_time, arg0.pre_unlock_vesting.vesting_period, arg0.pre_unlock_vesting.claimed_amount)
    }

    public fun get_pre_unlock_vesting_info(arg0: &PreUnlockVesting) : (u64, u64, u64, u64) {
        (arg0.amount, arg0.start_time, arg0.vesting_period, arg0.claimed_amount)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VAULT>(arg0, arg1);
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun lock<T0>(arg0: &mut VeTokenVault<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : VoteEscrowedToken<T0> {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        check_lock_period(arg3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 + arg3;
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(v2, arg3);
        0x2::balance::join<T0>(&mut arg0.total_locked_balance, arg2);
        arg0.total_max_voting_power = arg0.total_max_voting_power + v3;
        let (v4, v5, v6) = get_display_info(arg0.ve_token_count);
        let v7 = PreUnlockVesting{
            amount         : 0,
            start_time     : 0,
            vesting_period : 0,
            claimed_amount : 0,
        };
        let v8 = VoteEscrowedToken<T0>{
            id                  : 0x2::object::new(arg4),
            base_token          : 0x1::type_name::get<T0>(),
            locked_amount       : v2,
            max_voting_power    : v3,
            lock_start_time     : v0,
            lock_period         : arg3,
            lock_end_time       : v1,
            is_active           : true,
            is_always_max_power : false,
            pre_unlock_vesting  : v7,
            name                : v4,
            description         : v5,
            url                 : v6,
        };
        arg0.ve_token_count = arg0.ve_token_count + 1;
        let v9 = NAVXLocked{
            nft_id              : 0x2::object::uid_to_address(&v8.id),
            amount              : v2,
            lock_start_time     : v0,
            lock_end_time       : v1,
            max_voting_power    : v3,
            is_always_max_power : false,
        };
        0x2::event::emit<NAVXLocked>(v9);
        v8
    }

    public(friend) fun lock_for_max_power<T0>(arg0: &mut VeTokenVault<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : VoteEscrowedToken<T0> {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        let v0 = 63072000000;
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = v1 + v0;
        let v3 = 0x2::balance::value<T0>(&arg2);
        let v4 = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(v3, v0);
        0x2::balance::join<T0>(&mut arg0.total_locked_balance, arg2);
        arg0.total_max_voting_power = arg0.total_max_voting_power + v4;
        let (v5, v6, v7) = get_display_info(arg0.ve_token_count);
        let v8 = PreUnlockVesting{
            amount         : 0,
            start_time     : 0,
            vesting_period : 0,
            claimed_amount : 0,
        };
        let v9 = VoteEscrowedToken<T0>{
            id                  : 0x2::object::new(arg3),
            base_token          : 0x1::type_name::get<T0>(),
            locked_amount       : v3,
            max_voting_power    : v4,
            lock_start_time     : v1,
            lock_period         : v0,
            lock_end_time       : v2,
            is_active           : true,
            is_always_max_power : true,
            pre_unlock_vesting  : v8,
            name                : v5,
            description         : v6,
            url                 : v7,
        };
        arg0.ve_token_count = arg0.ve_token_count + 1;
        let v10 = NAVXLocked{
            nft_id              : 0x2::object::uid_to_address(&v9.id),
            amount              : v3,
            lock_start_time     : v1,
            lock_end_time       : v2,
            max_voting_power    : v4,
            is_always_max_power : true,
        };
        0x2::event::emit<NAVXLocked>(v10);
        v9
    }

    public(friend) fun merge_veToken<T0>(arg0: &mut VeTokenVault<T0>, arg1: vector<VoteEscrowedToken<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (VoteEscrowedToken<T0>, vector<VoteEscrowedToken<T0>>) {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = vector[];
        let v4 = 0x1::vector::length<VoteEscrowedToken<T0>>(&arg1);
        while (v4 > 0) {
            let v5 = 0x1::vector::borrow_mut<VoteEscrowedToken<T0>>(&mut arg1, v4 - 1);
            update_nft_lock_start_end_time<T0>(v5, arg2);
            check_nft_active<T0>(v5);
            check_already_pre_unlock_vesting<T0>(v5);
            v1 = v1 + v5.locked_amount;
            let v6 = if (v5.lock_end_time < v0) {
                0
            } else {
                v5.lock_end_time - v0
            };
            v2 = 0x1::u64::max(v2, v6);
            arg0.total_max_voting_power = arg0.total_max_voting_power - v5.max_voting_power;
            v5.is_active = false;
            0x1::vector::push_back<address>(&mut v3, 0x2::object::uid_to_address(&v5.id));
            v4 = v4 - 1;
        };
        let v7 = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(v1, v2);
        let (v8, v9, v10) = get_display_info(arg0.ve_token_count);
        let v11 = PreUnlockVesting{
            amount         : 0,
            start_time     : 0,
            vesting_period : 0,
            claimed_amount : 0,
        };
        let v12 = VoteEscrowedToken<T0>{
            id                  : 0x2::object::new(arg3),
            base_token          : 0x1::type_name::get<T0>(),
            locked_amount       : v1,
            max_voting_power    : v7,
            lock_start_time     : v0,
            lock_period         : v2,
            lock_end_time       : v0 + v2,
            is_active           : true,
            is_always_max_power : false,
            pre_unlock_vesting  : v11,
            name                : v8,
            description         : v9,
            url                 : v10,
        };
        arg0.ve_token_count = arg0.ve_token_count + 1;
        arg0.total_max_voting_power = arg0.total_max_voting_power + v7;
        let v13 = VeTokenMerged{
            nft_ids           : v3,
            new_nft_id        : 0x2::object::uid_to_address(&v12.id),
            new_locked_amount : v1,
            new_lock_period   : v2,
        };
        0x2::event::emit<VeTokenMerged>(v13);
        (v12, arg1)
    }

    public fun nft_id<T0>(arg0: &VoteEscrowedToken<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun nft_is_active<T0>(arg0: &VoteEscrowedToken<T0>) : bool {
        arg0.is_active
    }

    public fun nft_is_always_max_power<T0>(arg0: &VoteEscrowedToken<T0>) : bool {
        arg0.is_always_max_power
    }

    public fun nft_lock_end_time<T0>(arg0: &VoteEscrowedToken<T0>) : u64 {
        arg0.lock_end_time
    }

    public fun nft_lock_period<T0>(arg0: &VoteEscrowedToken<T0>) : u64 {
        arg0.lock_period
    }

    public fun nft_lock_start_time<T0>(arg0: &VoteEscrowedToken<T0>) : u64 {
        arg0.lock_start_time
    }

    public fun nft_locked_amount<T0>(arg0: &VoteEscrowedToken<T0>) : u64 {
        arg0.locked_amount
    }

    public fun nft_max_voting_power<T0>(arg0: &VoteEscrowedToken<T0>) : u64 {
        arg0.max_voting_power
    }

    public fun nft_pre_unlock_vesting<T0>(arg0: &VoteEscrowedToken<T0>) : &PreUnlockVesting {
        &arg0.pre_unlock_vesting
    }

    public(friend) fun pre_unlock<T0>(arg0: &mut VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        check_nft_active<T0>(arg1);
        check_already_pre_unlock_vesting<T0>(arg1);
        update_nft_lock_start_end_time<T0>(arg1, arg2);
        arg1.is_always_max_power = false;
        let v0 = 0x2::clock::timestamp_ms(arg2);
        check_vesting_period<T0>(arg1, v0, arg3);
        let v1 = arg1.locked_amount;
        let v2 = (((v1 as u128) * (0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_penalty_ratio(v0 - arg1.lock_start_time, arg1.lock_period, arg3) as u128) / (1000000 as u128)) as u64);
        let v3 = (v1 as u64) - v2;
        0x2::balance::join<T0>(&mut arg0.total_penalty_balance, 0x2::balance::split<T0>(&mut arg0.total_locked_balance, v2));
        arg1.pre_unlock_vesting.amount = v3;
        arg1.pre_unlock_vesting.start_time = v0;
        arg1.pre_unlock_vesting.vesting_period = arg3;
        arg1.locked_amount = v3;
        arg1.max_voting_power = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(v3, arg3);
        arg0.total_max_voting_power = arg0.total_max_voting_power - arg1.max_voting_power - arg1.max_voting_power;
        let v4 = PreUnlockStarted{
            nft_id         : 0x2::object::uid_to_address(&arg1.id),
            vesting_amount : v3,
            vesting_period : arg3,
        };
        0x2::event::emit<PreUnlockStarted>(v4);
    }

    public(friend) fun set_display<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<VoteEscrowedToken<T0>>(arg0), 1012);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::display::new_with_fields<VoteEscrowedToken<T0>>(arg0, v0, v2, arg1);
        0x2::display::update_version<VoteEscrowedToken<T0>>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<VoteEscrowedToken<T0>>>(v4, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun set_reward_manager<T0>(arg0: &mut VeTokenVault<T0>, arg1: address) {
        arg0.reward_manager = arg1;
        let v0 = RewardManagerSet{
            vault_id          : 0x2::object::uid_to_address(&arg0.id),
            reward_manager_id : arg1,
        };
        0x2::event::emit<RewardManagerSet>(v0);
    }

    public(friend) fun switch_to_always_max_power<T0>(arg0: &mut VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock) {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        check_nft_active<T0>(arg1);
        check_already_pre_unlock_vesting<T0>(arg1);
        assert!(!arg1.is_always_max_power, 1009);
        let v0 = arg1.max_voting_power;
        arg1.is_always_max_power = true;
        if (arg1.lock_period < 63072000000) {
            arg1.lock_period = 63072000000;
            arg1.max_voting_power = 0x6cd2542847cb15c80f272104bb33c76f25b1fc4505df6ce64af736657b596879::calculator::get_max_voting_power(arg1.locked_amount, 63072000000);
        };
        update_nft_lock_start_end_time<T0>(arg1, arg2);
        arg0.total_max_voting_power = arg0.total_max_voting_power - v0 + arg1.max_voting_power;
        let v1 = SwitchedToAlwaysMaxPower{nft_id: 0x2::object::uid_to_address(&arg1.id)};
        0x2::event::emit<SwitchedToAlwaysMaxPower>(v1);
    }

    public(friend) fun switch_to_normal<T0>(arg0: &VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock) {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        check_nft_active<T0>(arg1);
        assert!(arg1.is_always_max_power, 1010);
        update_nft_lock_start_end_time<T0>(arg1, arg2);
        arg1.is_always_max_power = false;
        let v0 = SwitchedToNormal{nft_id: 0x2::object::uid_to_address(&arg1.id)};
        0x2::event::emit<SwitchedToNormal>(v0);
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            let v1 = 0x1::vector::empty<u8>();
            while (!0x1::vector::is_empty<u8>(&v0)) {
                0x1::vector::push_back<u8>(&mut v1, 0x1::vector::pop_back<u8>(&mut v0));
            };
            v0 = v1;
        };
        0x1::string::utf8(v0)
    }

    public(friend) fun unlock<T0>(arg0: &mut VeTokenVault<T0>, arg1: &mut VoteEscrowedToken<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        check_version(arg0.version);
        check_enabled(arg0.enabled);
        update_nft_lock_start_end_time<T0>(arg1, arg2);
        check_nft_active<T0>(arg1);
        check_already_pre_unlock_vesting<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.lock_end_time, 1004);
        let v0 = arg1.locked_amount;
        arg0.total_max_voting_power = arg0.total_max_voting_power - arg1.max_voting_power;
        arg1.is_active = false;
        arg1.locked_amount = 0;
        arg1.max_voting_power = 0;
        let v1 = NAVXUnlocked{
            nft_id : 0x2::object::uid_to_address(&arg1.id),
            amount : v0,
        };
        0x2::event::emit<NAVXUnlocked>(v1);
        0x2::balance::split<T0>(&mut arg0.total_locked_balance, v0)
    }

    public(friend) fun update_nft_lock_start_end_time<T0>(arg0: &mut VoteEscrowedToken<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.is_always_max_power) {
            arg0.lock_start_time = v0;
            arg0.lock_end_time = v0 + 63072000000;
        };
    }

    public(friend) fun update_pre_unlock<T0>(arg0: &mut VoteEscrowedToken<T0>, arg1: &0x2::clock::Clock) : (u64, bool) {
        let v0 = &mut arg0.pre_unlock_vesting;
        assert!(v0.amount > 0, 1007);
        let v1 = 0x2::clock::timestamp_ms(arg1) - v0.start_time;
        let v2 = v0.vesting_period;
        let (v3, v4) = if (v1 >= v2) {
            (v0.amount, true)
        } else {
            ((((v0.amount as u128) * (v1 as u128) * (1000000 as u128) / (v2 as u128) / (1000000 as u128)) as u64), false)
        };
        let v5 = if (v3 > v0.claimed_amount) {
            v0.claimed_amount = v3;
            v3 - v0.claimed_amount
        } else {
            0
        };
        (v5, v4)
    }

    public(friend) fun upgrade_vault<T0>(arg0: &mut VeTokenVault<T0>) {
        assert!(arg0.version < 0, 1008);
        arg0.version = 0;
        let v0 = VaultUpgraded{
            vault_id : 0x2::object::uid_to_address(&arg0.id),
            version  : 0,
        };
        0x2::event::emit<VaultUpgraded>(v0);
    }

    public fun vault_average_lock_period<T0>(arg0: &VeTokenVault<T0>) : u64 {
        (((arg0.total_max_voting_power as u128) * (63072000000 as u128) / (0x2::balance::value<T0>(&arg0.total_locked_balance) as u128)) as u64)
    }

    public fun vault_enabled<T0>(arg0: &VeTokenVault<T0>) : bool {
        arg0.enabled
    }

    public fun vault_id<T0>(arg0: &VeTokenVault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun vault_reward_manager_id<T0>(arg0: &VeTokenVault<T0>) : address {
        arg0.reward_manager
    }

    public fun vault_total_locked_balance<T0>(arg0: &VeTokenVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_locked_balance)
    }

    public fun vault_total_max_voting_power<T0>(arg0: &VeTokenVault<T0>) : u64 {
        arg0.total_max_voting_power
    }

    public fun vault_total_penalty_balance<T0>(arg0: &VeTokenVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_penalty_balance)
    }

    public fun voting_power<T0>(arg0: &VoteEscrowedToken<T0>, arg1: &0x2::clock::Clock) : u64 {
        get_dynamic_voting_power<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

