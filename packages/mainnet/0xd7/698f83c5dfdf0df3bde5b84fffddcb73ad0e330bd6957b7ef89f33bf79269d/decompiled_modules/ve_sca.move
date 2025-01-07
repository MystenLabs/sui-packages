module 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca {
    struct VeSca has copy, drop, store {
        locked_sca_amount: u64,
        unlock_at: u64,
    }

    struct VeScaTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x2::object::ID, VeSca>,
    }

    struct VeScaKey has store, key {
        id: 0x2::object::UID,
    }

    struct VeScaMintedEvent has copy, drop {
        ve_sca_key: 0x2::object::ID,
        locked_sca_amount: u64,
        unlock_at: u64,
    }

    struct VeScaTopupEvent has copy, drop {
        ve_sca_key: 0x2::object::ID,
        topup_sca_amount: u64,
    }

    struct VeScaLockPeriodExtendedEvent has copy, drop {
        ve_sca_key: 0x2::object::ID,
        previous_unlock_at: u64,
        new_unlock_at: u64,
    }

    struct VeScaRedeemedEvent has copy, drop {
        ve_sca_key: 0x2::object::ID,
        redeemed_sca_amount: u64,
    }

    struct VeScaRenewedEvent has copy, drop {
        ve_sca_key: 0x2::object::ID,
        new_locked_sca_amount: u64,
        new_unlock_at: u64,
    }

    public fun extend_lock_period(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::VeScaTreasury, arg4: u64, arg5: &0x2::clock::Clock) {
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_extend_locking(arg4, v0.unlock_at, arg5);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::extend_lock_period(arg3, v0.locked_sca_amount, v0.unlock_at, arg4, arg5);
        v0.unlock_at = arg4;
        let v1 = VeScaLockPeriodExtendedEvent{
            ve_sca_key         : 0x2::object::id<VeScaKey>(arg1),
            previous_unlock_at : v0.unlock_at,
            new_unlock_at      : arg4,
        };
        0x2::event::emit<VeScaLockPeriodExtendedEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x2::object::ID, VeSca>(arg0),
        };
        0x2::transfer::share_object<VeScaTable>(v0);
    }

    public fun lock_more_sca(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::VeScaTreasury, arg4: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg4);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_locking_more(v0, v1.unlock_at, arg5);
        v1.locked_sca_amount = v1.locked_sca_amount + v0;
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::lock_sca(arg3, arg4, v1.unlock_at, arg5);
        let v2 = VeScaTopupEvent{
            ve_sca_key       : 0x2::object::id<VeScaKey>(arg1),
            topup_sca_amount : v0,
        };
        0x2::event::emit<VeScaTopupEvent>(v2);
    }

    public fun locked_sca_amount(arg0: 0x2::object::ID, arg1: &VeScaTable) : u64 {
        0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0).locked_sca_amount
    }

    public fun mint_ve_sca_key(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &mut VeScaTable, arg2: &mut 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::VeScaTreasury, arg3: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VeScaKey {
        let v0 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg3);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_initial_locking(v0, arg4, arg5);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::lock_sca(arg2, arg3, arg4, arg5);
        let v1 = VeScaKey{id: 0x2::object::new(arg6)};
        let v2 = VeSca{
            locked_sca_amount : v0,
            unlock_at         : arg4,
        };
        let v3 = 0x2::object::id<VeScaKey>(&v1);
        0x2::table::add<0x2::object::ID, VeSca>(&mut arg1.table, v3, v2);
        let v4 = VeScaMintedEvent{
            ve_sca_key        : v3,
            locked_sca_amount : v0,
            unlock_at         : arg4,
        };
        0x2::event::emit<VeScaMintedEvent>(v4);
        v1
    }

    public fun mint_ve_sca_placeholder_key(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &mut VeScaTable, arg2: &mut 0x2::tx_context::TxContext) : VeScaKey {
        let v0 = 0;
        let v1 = 0;
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        let v2 = VeScaKey{id: 0x2::object::new(arg2)};
        let v3 = VeSca{
            locked_sca_amount : v0,
            unlock_at         : v1,
        };
        let v4 = 0x2::object::id<VeScaKey>(&v2);
        0x2::table::add<0x2::object::ID, VeSca>(&mut arg1.table, v4, v3);
        let v5 = VeScaMintedEvent{
            ve_sca_key        : v4,
            locked_sca_amount : v0,
            unlock_at         : v1,
        };
        0x2::event::emit<VeScaMintedEvent>(v5);
        v2
    }

    public fun redeem(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::VeScaTreasury, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA> {
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        let v0 = 0x2::object::id<VeScaKey>(arg1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, v0);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_redeem_sca(v1.locked_sca_amount, v1.unlock_at, arg4);
        let v2 = v1.locked_sca_amount;
        v1.locked_sca_amount = 0;
        let v3 = VeScaRedeemedEvent{
            ve_sca_key          : v0,
            redeemed_sca_amount : v2,
        };
        0x2::event::emit<VeScaRedeemedEvent>(v3);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::withdraw_sca(arg3, v2, arg4, arg5)
    }

    public fun renew_expired_ve_sca(arg0: &0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::VeScaProtocolConfig, arg1: &VeScaKey, arg2: &mut VeScaTable, arg3: &mut 0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::VeScaTreasury, arg4: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VeSca>(&mut arg2.table, 0x2::object::id<VeScaKey>(arg1));
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::config::assert_protocol_version_and_status(arg0);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_renew_expired_ve_sca(v0.locked_sca_amount, v0.unlock_at, arg6);
        let v1 = 0x2::coin::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg4);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::ve_sca_rules::assert_for_initial_locking(v1, arg5, arg6);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::treasury::lock_sca(arg3, arg4, arg5, arg6);
        v0.locked_sca_amount = v1;
        v0.unlock_at = arg5;
        let v2 = VeScaRenewedEvent{
            ve_sca_key            : 0x2::object::id<VeScaKey>(arg1),
            new_locked_sca_amount : v1,
            new_unlock_at         : arg5,
        };
        0x2::event::emit<VeScaRenewedEvent>(v2);
    }

    public fun unlock_at(arg0: 0x2::object::ID, arg1: &VeScaTable) : u64 {
        0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0).unlock_at
    }

    public fun ve_sca_amount(arg0: 0x2::object::ID, arg1: &VeScaTable, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, VeSca>(&arg1.table, arg0);
        0xd7698f83c5dfdf0df3bde5b84fffddcb73ad0e330bd6957b7ef89f33bf79269d::calculator::calc_ve_sca(v0.locked_sca_amount, v0.unlock_at, arg2)
    }

    // decompiled from Move bytecode v6
}

