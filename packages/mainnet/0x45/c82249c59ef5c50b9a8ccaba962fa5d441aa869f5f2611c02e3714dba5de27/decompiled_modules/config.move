module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        protocol_fee_bps: u64,
        treasury: address,
        max_oracle_freshness_ms: u64,
        min_keeper_fee: u64,
        max_keeper_fee: u64,
    }

    struct ConfigRegistry has key {
        id: 0x2::object::UID,
        governance: address,
        current_config_id: 0x2::object::ID,
        current_config_version: u64,
    }

    struct ConfigPublished has copy, drop {
        config_id: 0x2::object::ID,
        version: u64,
        protocol_fee_bps: u64,
        treasury: address,
    }

    public fun assert_not_paused(arg0: &ProtocolConfig) {
        assert!(!arg0.paused, 104);
    }

    public fun calculate_protocol_fee(arg0: &ProtocolConfig, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.protocol_fee_bps as u128) / 10000) as u64)
    }

    public fun current_config_id(arg0: &ConfigRegistry) : 0x2::object::ID {
        arg0.current_config_id
    }

    public fun current_config_version(arg0: &ConfigRegistry) : u64 {
        arg0.current_config_version
    }

    public fun governance(arg0: &ConfigRegistry) : address {
        arg0.governance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = ProtocolConfig{
            id                      : v1,
            version                 : 1,
            paused                  : false,
            protocol_fee_bps        : 5,
            treasury                : v0,
            max_oracle_freshness_ms : 30000,
            min_keeper_fee          : 1000000,
            max_keeper_fee          : 1000000000,
        };
        let v4 = ConfigPublished{
            config_id        : v2,
            version          : 1,
            protocol_fee_bps : 5,
            treasury         : v0,
        };
        0x2::event::emit<ConfigPublished>(v4);
        0x2::transfer::freeze_object<ProtocolConfig>(v3);
        let v5 = ConfigRegistry{
            id                     : 0x2::object::new(arg0),
            governance             : v0,
            current_config_id      : v2,
            current_config_version : 1,
        };
        0x2::transfer::share_object<ConfigRegistry>(v5);
    }

    public fun max_keeper_fee(arg0: &ProtocolConfig) : u64 {
        arg0.max_keeper_fee
    }

    public fun max_oracle_freshness_ms(arg0: &ProtocolConfig) : u64 {
        arg0.max_oracle_freshness_ms
    }

    public fun min_keeper_fee(arg0: &ProtocolConfig) : u64 {
        arg0.min_keeper_fee
    }

    public fun paused(arg0: &ProtocolConfig) : bool {
        arg0.paused
    }

    public fun protocol_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public fun publish_config(arg0: &mut ConfigRegistry, arg1: bool, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.governance, 100);
        assert!(arg2 <= 10000, 101);
        assert!(arg5 <= arg6, 102);
        assert!(arg3 != @0x0, 103);
        let v0 = arg0.current_config_version + 1;
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = ProtocolConfig{
            id                      : v1,
            version                 : v0,
            paused                  : arg1,
            protocol_fee_bps        : arg2,
            treasury                : arg3,
            max_oracle_freshness_ms : arg4,
            min_keeper_fee          : arg5,
            max_keeper_fee          : arg6,
        };
        let v4 = ConfigPublished{
            config_id        : v2,
            version          : v0,
            protocol_fee_bps : arg2,
            treasury         : arg3,
        };
        0x2::event::emit<ConfigPublished>(v4);
        0x2::transfer::freeze_object<ProtocolConfig>(v3);
        arg0.current_config_id = v2;
        arg0.current_config_version = v0;
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    public fun version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

