module 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::claim {
    struct ArenaTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        token_address: 0x1::string::String,
        decimals: u64,
        balance: 0x2::balance::Balance<T0>,
        requested_ids: vector<0x1::string::String>,
        is_pause: bool,
    }

    struct ArenaMessage has drop {
        token_address: 0x1::string::String,
        user: address,
        amount: u64,
        request_id: 0x1::string::String,
        expired_at: u64,
    }

    struct ArenaTreasuryCreatedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        token_address: 0x1::string::String,
        decimals: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct ArenaTreasuryPausedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        is_pause: bool,
        updated_by: address,
    }

    struct UserClaimedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        request_id: 0x1::string::String,
        token_address: 0x1::string::String,
        user: address,
        amount: u64,
        decimals: u64,
        user_count: u64,
        claimed_at: u64,
    }

    struct ArenaTreasuryDepositedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        token_address: 0x1::string::String,
        decimals: u64,
        amount: u64,
        deposited_at: u64,
    }

    struct ArenaTreasuryWithdrawnEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        token_address: 0x1::string::String,
        decimals: u64,
        amount: u64,
        withdrawn_at: u64,
    }

    public fun changeSigner(arg0: &mut 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::ArenaStore, arg1: &0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg1, 0x2::tx_context::sender(arg3)), 11);
        0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::set_signer(arg0, arg2);
    }

    public fun createTreasury<T0>(arg0: &mut 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::ArenaStore, arg1: u64, arg2: &0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 11);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::set_treasury_id(arg0, v0), 7);
        let v1 = ArenaTreasury<T0>{
            id            : 0x2::object::new(arg3),
            token_address : v0,
            decimals      : arg1,
            balance       : 0x2::balance::zero<T0>(),
            requested_ids : 0x1::vector::empty<0x1::string::String>(),
            is_pause      : false,
        };
        let v2 = ArenaTreasuryCreatedEvent{
            treasury_id   : 0x2::object::id<ArenaTreasury<T0>>(&v1),
            token_address : v0,
            decimals      : arg1,
            coin_type     : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ArenaTreasuryCreatedEvent>(v2);
        0x2::transfer::share_object<ArenaTreasury<T0>>(v1);
    }

    public entry fun depositFund<T0>(arg0: &mut ArenaTreasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::coin::value<T0>(&arg1), 5);
        0x2::coin::put<T0>(&mut arg0.balance, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = ArenaTreasuryDepositedEvent{
            treasury_id   : 0x2::object::id<ArenaTreasury<T0>>(arg0),
            token_address : arg0.token_address,
            decimals      : arg0.decimals,
            amount        : arg2,
            deposited_at  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ArenaTreasuryDepositedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::create(arg0);
        0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::create(arg0);
    }

    fun is_executed<T0>(arg0: &ArenaTreasury<T0>, arg1: 0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.requested_ids, &arg1)
    }

    fun mark_executed<T0>(arg0: &mut ArenaTreasury<T0>, arg1: 0x1::string::String) {
        if (!0x1::vector::contains<0x1::string::String>(&arg0.requested_ids, &arg1)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.requested_ids, arg1);
        };
    }

    public fun pauseTreasury<T0>(arg0: &0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg1: &mut ArenaTreasury<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg0, v0), 11);
        arg1.is_pause = arg2;
        let v1 = ArenaTreasuryPausedEvent{
            treasury_id : 0x2::object::id<ArenaTreasury<T0>>(arg1),
            is_pause    : arg2,
            updated_by  : v0,
        };
        0x2::event::emit<ArenaTreasuryPausedEvent>(v1);
    }

    public fun removeAdmin(arg0: &mut 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg0, v0), 11);
        assert!(arg1 != v0, 0);
        0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::remove_admin(arg0, arg1);
    }

    entry fun requestClaim<T0>(arg0: &mut 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::ArenaStore, arg1: &mut ArenaTreasury<T0>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_pause, 6);
        assert!(arg6 > 0x2::clock::timestamp_ms(arg7), 1);
        assert!(!is_executed<T0>(arg1, arg5), 2);
        let v0 = ArenaMessage{
            token_address : arg1.token_address,
            user          : arg3,
            amount        : arg4,
            request_id    : arg5,
            expired_at    : arg6,
        };
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::is_valid_signature(arg0, arg2, 0x2::bcs::to_bytes<ArenaMessage>(&v0)), 0);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 3);
        mark_executed<T0>(arg1, arg5);
        let v1 = &mut arg1.balance;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take_coins<T0>(v1, arg4, arg8), arg3);
        let v2 = UserClaimedEvent{
            treasury_id   : 0x2::object::id<ArenaTreasury<T0>>(arg1),
            request_id    : arg5,
            token_address : arg1.token_address,
            user          : arg3,
            amount        : arg4,
            decimals      : arg1.decimals,
            user_count    : 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::arena::set_user(arg0, arg3, arg4),
            claimed_at    : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UserClaimedEvent>(v2);
    }

    public fun setAdmin(arg0: &mut 0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg0, 0x2::tx_context::sender(arg2)), 11);
        0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::set_admin(arg0, arg1);
    }

    fun take_coins<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(arg0, arg1, arg2)
    }

    public entry fun withdrawFund<T0>(arg0: &mut ArenaTreasury<T0>, arg1: u64, arg2: &0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x731da820043264c8c3650ae514b866d23c8be679679513b908ed94a7e4ec3f0f::permission::is_admin(arg2, v0), 11);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        let v1 = &mut arg0.balance;
        let v2 = take_coins<T0>(v1, arg1, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        let v3 = ArenaTreasuryWithdrawnEvent{
            treasury_id   : 0x2::object::id<ArenaTreasury<T0>>(arg0),
            token_address : arg0.token_address,
            decimals      : arg0.decimals,
            amount        : arg1,
            withdrawn_at  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ArenaTreasuryWithdrawnEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

