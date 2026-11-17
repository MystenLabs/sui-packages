module 0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::nami_treasury {
    struct MasterTreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct CommunityTreasury has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        vaults: 0x2::bag::Bag,
    }

    struct Vault<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        received: u64,
    }

    struct TreasuryCreatedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
    }

    struct TreasuryReceivedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        coin_id: 0x2::object::ID,
        amount: u64,
        balance_after: u64,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun balance<T0>(arg0: &CommunityTreasury) : u64 {
        if (!has_vault<T0>(arg0)) {
            return 0
        };
        0x2::balance::value<T0>(&borrow_vault<T0>(arg0).balance)
    }

    public fun accept<T0>(arg0: &mut CommunityTreasury, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::assert_version(&arg0.allowed_versions);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<T0>(v0);
            return
        };
        let v2 = vault_entry<T0>(arg0);
        0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(v0));
        v2.received = v2.received + v1;
        let v3 = TreasuryReceivedEvent{
            treasury_id   : 0x2::object::id<CommunityTreasury>(arg0),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            coin_id       : 0x2::object::id<0x2::coin::Coin<T0>>(&v0),
            amount        : v1,
            balance_after : 0x2::balance::value<T0>(&v2.balance),
        };
        0x2::event::emit<TreasuryReceivedEvent>(v3);
    }

    public fun allowed_versions(arg0: &CommunityTreasury) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public(friend) fun assert_allowed_version(arg0: &CommunityTreasury) {
        0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::assert_version(&arg0.allowed_versions);
    }

    fun borrow_vault<T0>(arg0: &CommunityTreasury) : &Vault<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, Vault<T0>>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun disable_version(arg0: &MasterTreasuryCap, arg1: &mut CommunityTreasury, arg2: u64) {
        assert!(arg2 != 0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 2);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<CommunityTreasury>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &MasterTreasuryCap, arg1: &mut CommunityTreasury, arg2: u64) {
        assert!(arg2 <= 0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::current_version() + 1, 1);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<CommunityTreasury>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public fun has_vault<T0>(arg0: &CommunityTreasury) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_treasury(0x2::vec_set::singleton<u64>(0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::current_version()), arg0);
        let v1 = TreasuryCreatedEvent{treasury_id: 0x2::object::id<CommunityTreasury>(&v0)};
        0x2::event::emit<TreasuryCreatedEvent>(v1);
        0x2::transfer::share_object<CommunityTreasury>(v0);
        let v2 = MasterTreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MasterTreasuryCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun new_treasury(arg0: 0x2::vec_set::VecSet<u64>, arg1: &mut 0x2::tx_context::TxContext) : CommunityTreasury {
        CommunityTreasury{
            id               : 0x2::object::new(arg1),
            allowed_versions : arg0,
            vaults           : 0x2::bag::new(arg1),
        }
    }

    public fun received<T0>(arg0: &CommunityTreasury) : u64 {
        if (!has_vault<T0>(arg0)) {
            return 0
        };
        borrow_vault<T0>(arg0).received
    }

    public(friend) fun take<T0>(arg0: &mut CommunityTreasury, arg1: u64) : 0x2::balance::Balance<T0> {
        0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::assert_version(&arg0.allowed_versions);
        0x2::balance::split<T0>(&mut 0x2::bag::borrow_mut<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.vaults, 0x1::type_name::with_defining_ids<T0>()).balance, arg1)
    }

    public(friend) fun uid(arg0: &CommunityTreasury) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut CommunityTreasury) : &mut 0x2::object::UID {
        0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::assert_version(&arg0.allowed_versions);
        &mut arg0.id
    }

    fun vault_entry<T0>(arg0: &mut CommunityTreasury) : &mut Vault<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0)) {
            let v1 = Vault<T0>{
                balance  : 0x2::balance::zero<T0>(),
                received : 0,
            };
            0x2::bag::add<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.vaults, v0, v1);
        };
        0x2::bag::borrow_mut<0x1::type_name::TypeName, Vault<T0>>(&mut arg0.vaults, v0)
    }

    public(friend) fun vault_mut<T0>(arg0: &mut CommunityTreasury) : &mut 0x2::balance::Balance<T0> {
        0x4792486eeb783b7832434d43ad3070924ec3e5d4497c9bb5845926f490864300::version::assert_version(&arg0.allowed_versions);
        &mut vault_entry<T0>(arg0).balance
    }

    // decompiled from Move bytecode v7
}

