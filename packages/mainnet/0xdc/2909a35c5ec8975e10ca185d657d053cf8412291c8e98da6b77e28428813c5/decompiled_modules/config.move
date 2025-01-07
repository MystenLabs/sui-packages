module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::config {
    struct PoolConfig has key {
        id: 0x2::object::UID,
        signer_pk: vector<u8>,
        owner: address,
        fund_addr: address,
        expired_ms: u64,
        fee_cut: u32,
        is_paused: bool,
        is_use_native_random: bool,
        is_verify_sig: bool,
        cost_supports: vector<u32>,
        pool_user_max_map: 0x2::table::Table<u16, u32>,
        pool_count: u32,
        executed: vector<vector<u8>>,
    }

    struct PoolConfigUpdateEvent has copy, drop, store {
        signer_pk: vector<u8>,
        owner: address,
        expired_ms: u64,
        fee_cut: u32,
        fund_addr: address,
        updated_at: u64,
    }

    struct PoolMaxUserUpdateEvent has copy, drop, store {
        pool_type: u16,
        max_user: u32,
    }

    struct PauseSystemEvent has copy, drop, store {
        value: bool,
        updated_by: address,
        updated_at: u64,
    }

    public fun changeExpiredhours(arg0: &mut PoolConfig, arg1: u64, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        assert!(arg1 < 720, 5);
        let v0 = arg1 * 60 * 60 * 1000;
        arg0.expired_ms = v0;
        let v1 = PoolConfigUpdateEvent{
            signer_pk  : arg0.signer_pk,
            owner      : arg0.owner,
            expired_ms : v0,
            fee_cut    : arg0.fee_cut,
            fund_addr  : arg0.fund_addr,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v1);
    }

    public fun changeFeecut(arg0: &mut PoolConfig, arg1: u32, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.fee_cut = arg1;
        let v0 = PoolConfigUpdateEvent{
            signer_pk  : arg0.signer_pk,
            owner      : arg0.owner,
            expired_ms : arg0.expired_ms,
            fee_cut    : arg1,
            fund_addr  : arg0.fund_addr,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v0);
    }

    public fun changeFundAddr(arg0: &mut PoolConfig, arg1: address, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.fund_addr = arg1;
        let v0 = PoolConfigUpdateEvent{
            signer_pk  : arg0.signer_pk,
            owner      : arg0.owner,
            expired_ms : arg0.expired_ms,
            fee_cut    : arg0.fee_cut,
            fund_addr  : arg1,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v0);
    }

    public fun changeOwner(arg0: &mut PoolConfig, arg1: address, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        assert!(arg0.owner != arg1, 100);
        arg0.owner = arg1;
        let v0 = PoolConfigUpdateEvent{
            signer_pk  : arg0.signer_pk,
            owner      : arg0.owner,
            expired_ms : arg0.expired_ms,
            fee_cut    : arg0.fee_cut,
            fund_addr  : arg0.fund_addr,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v0);
        arg1
    }

    public(friend) fun check_cost_support(arg0: &PoolConfig, arg1: u32) : bool {
        0x1::vector::contains<u32>(&arg0.cost_supports, &arg1)
    }

    public fun cost_supports(arg0: &PoolConfig) : vector<u32> {
        arg0.cost_supports
    }

    public fun expired_ms(arg0: &PoolConfig) : u64 {
        arg0.expired_ms
    }

    public fun fee_cut(arg0: &PoolConfig) : u32 {
        arg0.fee_cut
    }

    public fun fund_addr(arg0: &PoolConfig) : address {
        arg0.fund_addr
    }

    public fun getConfig(arg0: &PoolConfig) : (address, address, u64, u32, bool) {
        (arg0.owner, arg0.fund_addr, arg0.expired_ms, arg0.fee_cut, arg0.is_paused)
    }

    public(friend) fun increase_pcount(arg0: &mut PoolConfig) : u32 {
        arg0.pool_count = arg0.pool_count + 1;
        arg0.pool_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PoolConfig{
            id                   : 0x2::object::new(arg0),
            signer_pk            : 0x1::vector::empty<u8>(),
            owner                : v0,
            fund_addr            : v0,
            expired_ms           : 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::EXPIRED_MS(),
            fee_cut              : 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant::FEE_OWNER_CUT(),
            is_paused            : false,
            is_use_native_random : true,
            is_verify_sig        : true,
            cost_supports        : initSupportedPrices(),
            pool_user_max_map    : 0x2::table::new<u16, u32>(arg0),
            pool_count           : 0,
            executed             : 0x1::vector::empty<vector<u8>>(),
        };
        let v2 = PoolConfigUpdateEvent{
            signer_pk  : v1.signer_pk,
            owner      : v0,
            expired_ms : v1.expired_ms,
            fee_cut    : v1.fee_cut,
            fund_addr  : v0,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v2);
        0x2::transfer::share_object<PoolConfig>(v1);
    }

    fun initSupportedPrices() : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        0x1::vector::push_back<u32>(&mut v0, 1);
        0x1::vector::push_back<u32>(&mut v0, 10);
        0x1::vector::push_back<u32>(&mut v0, 100);
        v0
    }

    public(friend) fun is_executed(arg0: &PoolConfig, arg1: vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.executed, &arg1)
    }

    public fun is_paused(arg0: &PoolConfig) : bool {
        arg0.is_paused
    }

    public fun is_use_native_random(arg0: &PoolConfig) : bool {
        arg0.is_use_native_random
    }

    public fun is_verify_sig(arg0: &PoolConfig) : bool {
        arg0.is_verify_sig
    }

    public fun max_user(arg0: &PoolConfig, arg1: u16) : u32 {
        if (0x2::table::contains<u16, u32>(&arg0.pool_user_max_map, arg1)) {
            return *0x2::table::borrow<u16, u32>(&arg0.pool_user_max_map, arg1)
        };
        0
    }

    entry fun pauseSystem(arg0: &mut PoolConfig, arg1: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg1, v0), 3);
        arg0.is_paused = true;
        let v1 = PauseSystemEvent{
            value      : true,
            updated_by : v0,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<PauseSystemEvent>(v1);
    }

    public fun pool_count(arg0: &PoolConfig) : u32 {
        arg0.pool_count
    }

    public fun removeSupportedPrices(arg0: &mut PoolConfig, arg1: u32, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        let (v0, v1) = 0x1::vector::index_of<u32>(&arg0.cost_supports, &arg1);
        if (v0) {
            0x1::vector::remove<u32>(&mut arg0.cost_supports, v1);
        };
    }

    public fun setPoolMaxUser(arg0: &mut PoolConfig, arg1: u16, arg2: u32, arg3: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg3, 0x2::tx_context::sender(arg4)), 3);
        if (0x2::table::contains<u16, u32>(&arg0.pool_user_max_map, arg1)) {
            0x2::table::remove<u16, u32>(&mut arg0.pool_user_max_map, arg1);
        };
        0x2::table::add<u16, u32>(&mut arg0.pool_user_max_map, arg1, arg2);
        let v0 = PoolMaxUserUpdateEvent{
            pool_type : arg1,
            max_user  : arg2,
        };
        0x2::event::emit<PoolMaxUserUpdateEvent>(v0);
    }

    public fun setSignerAddress(arg0: &mut PoolConfig, arg1: vector<u8>, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.signer_pk = arg1;
        let v0 = PoolConfigUpdateEvent{
            signer_pk  : arg0.signer_pk,
            owner      : arg0.owner,
            expired_ms : arg0.expired_ms,
            fee_cut    : arg0.fee_cut,
            fund_addr  : arg0.fund_addr,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v0);
    }

    public fun setSupportedPrices(arg0: &mut PoolConfig, arg1: vector<u32>, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            let v1 = *0x1::vector::borrow<u32>(&arg1, v0);
            if (!check_cost_support(arg0, v1)) {
                0x1::vector::push_back<u32>(&mut arg0.cost_supports, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun setUseNativeRandom(arg0: &mut PoolConfig, arg1: bool, arg2: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.is_use_native_random = arg1;
    }

    public(friend) fun set_executed(arg0: &mut PoolConfig, arg1: vector<u8>) {
        if (!is_executed(arg0, arg1)) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.executed, arg1);
        };
    }

    public fun signer_pk(arg0: &PoolConfig) : vector<u8> {
        arg0.signer_pk
    }

    entry fun unPauseSystem(arg0: &mut PoolConfig, arg1: &0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg1, v0), 3);
        arg0.is_paused = false;
        let v1 = PauseSystemEvent{
            value      : false,
            updated_by : v0,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<PauseSystemEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

