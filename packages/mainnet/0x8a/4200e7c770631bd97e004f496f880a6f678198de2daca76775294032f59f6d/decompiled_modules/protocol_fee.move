module 0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::protocol_fee {
    struct ProtocolFeeVault has key {
        id: 0x2::object::UID,
        policy_version: u64,
        protocol_cut_rate: u64,
        capture_rate: u64,
        volume_cap_rate: u64,
        signers: 0x2::vec_map::VecMap<u64, vector<u8>>,
        capture_paused: bool,
    }

    struct InitProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct RateChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        param: u8,
        old_rate: u64,
        new_rate: u64,
        policy_version: u64,
    }

    struct SignerChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        signer_version: u64,
        pubkey: vector<u8>,
        added: bool,
    }

    struct CapturePausedChangedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct CollectEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun add_signer(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64, arg4: vector<u8>) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 2);
        assert!(!0x2::vec_map::contains<u64, vector<u8>>(&arg2.signers, &arg3), 3);
        0x2::vec_map::insert<u64, vector<u8>>(&mut arg2.signers, arg3, arg4);
        let v0 = SignerChangedEvent{
            vault_id       : 0x2::object::id<ProtocolFeeVault>(arg2),
            signer_version : arg3,
            pubkey         : arg4,
            added          : true,
        };
        0x2::event::emit<SignerChangedEvent>(v0);
    }

    public fun capture_paused(arg0: &ProtocolFeeVault) : bool {
        arg0.capture_paused
    }

    public fun capture_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.capture_rate
    }

    public fun collect<T0>(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        let v0 = CollectEvent{
            vault_id  : 0x2::object::id<ProtocolFeeVault>(arg2),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg3,
            recipient : arg4,
        };
        0x2::event::emit<CollectEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg2.id, arg3)), arg5), arg4);
    }

    public(friend) fun deposit<T0>(arg0: &ProtocolFeeVault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        0x2::balance::send_funds<T0>(arg1, 0x2::object::id_address<ProtocolFeeVault>(arg0));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_vault(arg0);
        let v1 = InitProtocolFeeEvent{vault_id: 0x2::object::id<ProtocolFeeVault>(&v0)};
        0x2::event::emit<InitProtocolFeeEvent>(v1);
        0x2::transfer::share_object<ProtocolFeeVault>(v0);
    }

    fun new_vault(arg0: &mut 0x2::tx_context::TxContext) : ProtocolFeeVault {
        ProtocolFeeVault{
            id                : 0x2::object::new(arg0),
            policy_version    : 1,
            protocol_cut_rate : 200000,
            capture_rate      : 0,
            volume_cap_rate   : 0,
            signers           : 0x2::vec_map::empty<u64, vector<u8>>(),
            capture_paused    : false,
        }
    }

    public fun policy_version(arg0: &ProtocolFeeVault) : u64 {
        arg0.policy_version
    }

    public fun protocol_cut_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.protocol_cut_rate
    }

    public fun rate_denominator() : u64 {
        1000000
    }

    public fun remove_signer(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(0x2::vec_map::contains<u64, vector<u8>>(&arg2.signers, &arg3), 4);
        let (_, v1) = 0x2::vec_map::remove<u64, vector<u8>>(&mut arg2.signers, &arg3);
        let v2 = SignerChangedEvent{
            vault_id       : 0x2::object::id<ProtocolFeeVault>(arg2),
            signer_version : arg3,
            pubkey         : v1,
            added          : false,
        };
        0x2::event::emit<SignerChangedEvent>(v2);
    }

    public fun set_capture_paused(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: bool) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        arg2.capture_paused = arg3;
        let v0 = CapturePausedChangedEvent{
            vault_id : 0x2::object::id<ProtocolFeeVault>(arg2),
            paused   : arg3,
        };
        0x2::event::emit<CapturePausedChangedEvent>(v0);
    }

    public fun set_capture_rate(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        arg2.policy_version = arg2.policy_version + 1;
        let v0 = RateChangedEvent{
            vault_id       : 0x2::object::id<ProtocolFeeVault>(arg2),
            param          : 1,
            old_rate       : arg2.capture_rate,
            new_rate       : arg3,
            policy_version : arg2.policy_version,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.capture_rate = arg3;
    }

    public fun set_protocol_cut_rate(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        arg2.policy_version = arg2.policy_version + 1;
        let v0 = RateChangedEvent{
            vault_id       : 0x2::object::id<ProtocolFeeVault>(arg2),
            param          : 0,
            old_rate       : arg2.protocol_cut_rate,
            new_rate       : arg3,
            policy_version : arg2.policy_version,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.protocol_cut_rate = arg3;
    }

    public fun set_volume_cap_rate(arg0: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::admin_cap::AdminCap, arg1: &0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::Versioned, arg2: &mut ProtocolFeeVault, arg3: u64) {
        0xb0e5e87c15aae553e2c1557e42c459766db869d27b72ce11de77383df3dc709a::versioned::check_version(arg1);
        assert!(arg3 <= 1000000, 1);
        arg2.policy_version = arg2.policy_version + 1;
        let v0 = RateChangedEvent{
            vault_id       : 0x2::object::id<ProtocolFeeVault>(arg2),
            param          : 2,
            old_rate       : arg2.volume_cap_rate,
            new_rate       : arg3,
            policy_version : arg2.policy_version,
        };
        0x2::event::emit<RateChangedEvent>(v0);
        arg2.volume_cap_rate = arg3;
    }

    public fun signer_pubkey(arg0: &ProtocolFeeVault, arg1: u64) : 0x1::option::Option<vector<u8>> {
        if (0x2::vec_map::contains<u64, vector<u8>>(&arg0.signers, &arg1)) {
            0x1::option::some<vector<u8>>(*0x2::vec_map::get<u64, vector<u8>>(&arg0.signers, &arg1))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun volume_cap_rate(arg0: &ProtocolFeeVault) : u64 {
        arg0.volume_cap_rate
    }

    // decompiled from Move bytecode v7
}

