module 0x526ac94fa5cafa6186840a1bfd4a4ffa6f649aad09b916f915df153dde59f2ca::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        owner: address,
        heir: address,
        period_ms: u64,
        last_confirmed_at: u64,
        yield_strategy: u8,
        asset_kind: u8,
        is_active: bool,
    }

    struct VaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        heir: address,
        period_ms: u64,
        yield_strategy: u8,
        asset_kind: u8,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct HeartbeatConfirmed has copy, drop {
        vault_id: 0x2::object::ID,
        confirmed_at: u64,
        next_deadline: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct Claimed has copy, drop {
        vault_id: 0x2::object::ID,
        heir: address,
        triggered_by: address,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct VaultDeactivated has copy, drop {
        vault_id: 0x2::object::ID,
        reason: vector<u8>,
    }

    struct HeirUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_heir: address,
        new_heir: address,
    }

    struct PeriodUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        old_period_ms: u64,
        new_period_ms: u64,
    }

    struct VaultClosed has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        closed_by: address,
    }

    fun assert_owner(arg0: &Vault, arg1: &VaultOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
    }

    fun assert_vault_asset_match<T0>(arg0: &Vault) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        let v1 = if (arg0.asset_kind == 0 && v0 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
            true
        } else if (arg0.asset_kind == 1 && v0 == b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL") {
            true
        } else if (arg0.asset_kind == 2 && v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            true
        } else {
            arg0.asset_kind == 3 && v0 == b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT"
        };
        assert!(v1, 9);
    }

    fun asset_kind_for_type<T0>() : u8 {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (v0 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
            0
        } else if (v0 == b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL") {
            1
        } else if (v0 == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC") {
            2
        } else {
            assert!(v0 == b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT", 8);
            3
        }
    }

    fun asset_type_name_for_kind(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"
        } else if (arg0 == 1) {
            b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL"
        } else if (arg0 == 2) {
            b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
        } else {
            assert!(arg0 == 3, 8);
            b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT"
        }
    }

    public entry fun claim<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_confirmed_at > arg0.period_ms, 2);
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 7);
        let v1 = 0x2::dynamic_field::remove<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg0.heir);
        arg0.is_active = false;
        let v2 = Claimed{
            vault_id     : 0x2::object::id<Vault>(arg0),
            heir         : arg0.heir,
            triggered_by : 0x2::tx_context::sender(arg2),
            coin_type    : asset_type_name_for_kind(arg0.asset_kind),
            amount       : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<Claimed>(v2);
        let v3 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"claimed",
        };
        0x2::event::emit<VaultDeactivated>(v3);
    }

    public entry fun close_vault<T0>(arg0: &mut Vault, arg1: VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, &arg1, arg2);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::remove<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg0.owner);
            let v2 = Withdrawn{
                vault_id  : 0x2::object::id<Vault>(arg0),
                owner     : arg0.owner,
                coin_type : asset_type_name_for_kind(arg0.asset_kind),
                amount    : 0x2::balance::value<T0>(&v1),
            };
            0x2::event::emit<Withdrawn>(v2);
        };
        arg0.is_active = false;
        let v3 = VaultClosed{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : arg0.owner,
            closed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultClosed>(v3);
        let v4 = VaultDeactivated{
            vault_id : 0x2::object::id<Vault>(arg0),
            reason   : b"closed",
        };
        0x2::event::emit<VaultDeactivated>(v4);
        let VaultOwnerCap {
            id       : v5,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v5);
    }

    public entry fun create_vault<T0>(arg0: &mut 0x526ac94fa5cafa6186840a1bfd4a4ffa6f649aad09b916f915df153dde59f2ca::registry::Registry, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 60000, 4);
        assert!(arg3 == 0, 5);
        assert!(arg1 != @0x0, 6);
        let v0 = asset_kind_for_type<T0>();
        let v1 = Vault{
            id                : 0x2::object::new(arg5),
            owner             : 0x2::tx_context::sender(arg5),
            heir              : arg1,
            period_ms         : arg2,
            last_confirmed_at : 0x2::clock::timestamp_ms(arg4),
            yield_strategy    : arg3,
            asset_kind        : v0,
            is_active         : true,
        };
        let v2 = 0x2::object::id<Vault>(&v1);
        0x526ac94fa5cafa6186840a1bfd4a4ffa6f649aad09b916f915df153dde59f2ca::registry::register_vault(arg0, v2, 0x2::tx_context::sender(arg5), arg1);
        let v3 = VaultOwnerCap{
            id       : 0x2::object::new(arg5),
            vault_id : v2,
        };
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<VaultOwnerCap>(v3, 0x2::tx_context::sender(arg5));
        let v4 = VaultCreated{
            vault_id       : v2,
            owner          : 0x2::tx_context::sender(arg5),
            heir           : arg1,
            period_ms      : arg2,
            yield_strategy : arg3,
            asset_kind     : v0,
        };
        0x2::event::emit<VaultCreated>(v4);
    }

    public entry fun deposit<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
        let v1 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun get_asset_kind(arg0: &Vault) : u8 {
        arg0.asset_kind
    }

    public fun get_balance<T0>(arg0: &Vault) : u64 {
        assert_vault_asset_match<T0>(arg0);
        let v0 = CoinKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_heir(arg0: &Vault) : address {
        arg0.heir
    }

    public fun get_last_confirmed(arg0: &Vault) : u64 {
        arg0.last_confirmed_at
    }

    public fun get_owner(arg0: &Vault) : address {
        arg0.owner
    }

    public fun get_period(arg0: &Vault) : u64 {
        arg0.period_ms
    }

    public fun get_yield_strategy(arg0: &Vault) : u8 {
        arg0.yield_strategy
    }

    public entry fun heartbeat(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.last_confirmed_at = v0;
        let v1 = HeartbeatConfirmed{
            vault_id      : 0x2::object::id<Vault>(arg0),
            confirmed_at  : v0,
            next_deadline : v0 + arg0.period_ms,
        };
        0x2::event::emit<HeartbeatConfirmed>(v1);
    }

    public fun is_active(arg0: &Vault) : bool {
        arg0.is_active
    }

    public fun is_claimable(arg0: &Vault, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) - arg0.last_confirmed_at > arg0.period_ms
    }

    public entry fun update_heir(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert!(arg2 != @0x0, 6);
        arg0.heir = arg2;
        let v0 = HeirUpdated{
            vault_id : 0x2::object::id<Vault>(arg0),
            old_heir : arg0.heir,
            new_heir : arg2,
        };
        0x2::event::emit<HeirUpdated>(v0);
    }

    public entry fun update_period(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert!(arg2 >= 60000, 4);
        arg0.period_ms = arg2;
        let v0 = PeriodUpdated{
            vault_id      : 0x2::object::id<Vault>(arg0),
            old_period_ms : arg0.period_ms,
            new_period_ms : arg2,
        };
        0x2::event::emit<PeriodUpdated>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Vault, arg1: &VaultOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1, arg3);
        assert!(arg0.is_active, 1);
        assert_vault_asset_match<T0>(arg0);
        let v0 = CoinKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v2 = Withdrawn{
            vault_id  : 0x2::object::id<Vault>(arg0),
            owner     : 0x2::tx_context::sender(arg3),
            coin_type : asset_type_name_for_kind(arg0.asset_kind),
            amount    : arg2,
        };
        0x2::event::emit<Withdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

