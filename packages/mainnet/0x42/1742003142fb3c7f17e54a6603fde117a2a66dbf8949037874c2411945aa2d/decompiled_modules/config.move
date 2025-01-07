module 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::config {
    struct PoolConfig has key {
        id: 0x2::object::UID,
        signer_pk: vector<u8>,
        owner: address,
        fund_addr: address,
        expired_ms_support: vector<u64>,
        fee_cut: u32,
        fee_cut_creator: u32,
        is_paused: bool,
        is_use_native_random: bool,
        is_verify_sig: bool,
        pool_max_users: u32,
        pool_count: u32,
        required_cost_in_usd_bps: u32,
        prevent_spin_early: bool,
        executed: vector<vector<u8>>,
    }

    struct PoolConfigUpdateEvent has copy, drop, store {
        signer_pk: vector<u8>,
        owner: address,
        fee_cut: u32,
        fee_cut_creator: u32,
        fund_addr: address,
        expired_ms_support: vector<u64>,
        required_cost_in_usd_bps: u32,
        prevent_spin_early: bool,
        pool_max_users: u32,
        updated_at: u64,
    }

    struct PoolSignerUpdateEvent has copy, drop, store {
        signer_pk: vector<u8>,
        updated_at: u64,
    }

    struct PoolOwnerUpdateEvent has copy, drop, store {
        owner: address,
        updated_at: u64,
    }

    struct PoolFundAddrUpdateEvent has copy, drop, store {
        fund_addr: address,
        updated_at: u64,
    }

    struct PoolFeecutUpdateEvent has copy, drop, store {
        fee_cut: u32,
        fee_cut_creator: u32,
        updated_at: u64,
    }

    struct PoolExpiredMsSupportEvent has copy, drop, store {
        expired_ms_support: vector<u64>,
        updated_at: u64,
    }

    struct PoolMaxUserUpdateEvent has copy, drop, store {
        max_user: u32,
        updated_at: u64,
    }

    struct PoolRequiredCostUsdUpdateEvent has copy, drop, store {
        required_cost_in_usd_bps: u32,
        updated_at: u64,
    }

    struct PauseSystemEvent has copy, drop, store {
        value: bool,
        updated_by: address,
        updated_at: u64,
    }

    public fun changeFeecut(arg0: &mut PoolConfig, arg1: u32, arg2: u32, arg3: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg3, 0x2::tx_context::sender(arg4)), 3);
        arg0.fee_cut = arg1;
        arg0.fee_cut_creator = arg2;
        let v0 = PoolFeecutUpdateEvent{
            fee_cut         : arg1,
            fee_cut_creator : arg2,
            updated_at      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<PoolFeecutUpdateEvent>(v0);
    }

    public fun changeFundAddr(arg0: &mut PoolConfig, arg1: address, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.fund_addr = arg1;
        let v0 = PoolFundAddrUpdateEvent{
            fund_addr  : arg1,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolFundAddrUpdateEvent>(v0);
    }

    public fun changeOwner(arg0: &mut PoolConfig, arg1: address, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        assert!(arg0.owner != arg1, 100);
        arg0.owner = arg1;
        let v0 = PoolOwnerUpdateEvent{
            owner      : arg0.owner,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolOwnerUpdateEvent>(v0);
        arg1
    }

    public(friend) fun check_max_user_support(arg0: &PoolConfig, arg1: u32) : bool {
        arg0.pool_max_users >= arg1
    }

    public(friend) fun check_required_cost(arg0: &PoolConfig, arg1: u32) : bool {
        arg1 >= arg0.required_cost_in_usd_bps
    }

    public(friend) fun check_time_to_join_support(arg0: &PoolConfig, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.expired_ms_support, &arg1)
    }

    public fun expired_ms_support(arg0: &PoolConfig) : vector<u64> {
        arg0.expired_ms_support
    }

    public fun fee_cut(arg0: &PoolConfig) : u32 {
        arg0.fee_cut
    }

    public fun fee_cut_creator(arg0: &PoolConfig) : u32 {
        arg0.fee_cut_creator
    }

    public fun fund_addr(arg0: &PoolConfig) : address {
        arg0.fund_addr
    }

    public(friend) fun increase_pcount(arg0: &mut PoolConfig) : u32 {
        arg0.pool_count = arg0.pool_count + 1;
        arg0.pool_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PoolConfig{
            id                       : 0x2::object::new(arg0),
            signer_pk                : 0x1::vector::empty<u8>(),
            owner                    : v0,
            fund_addr                : v0,
            expired_ms_support       : initExpiredMsSupport(),
            fee_cut                  : 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::FEE_OWNER_CUT(),
            fee_cut_creator          : 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::FEE_CREATOR_CUT(),
            is_paused                : false,
            is_use_native_random     : true,
            is_verify_sig            : true,
            pool_max_users           : 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::POOL_MAX_USER(),
            pool_count               : 0,
            required_cost_in_usd_bps : 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::REQUIRED_COST_IN_USD_BPS(),
            prevent_spin_early       : false,
            executed                 : 0x1::vector::empty<vector<u8>>(),
        };
        let v2 = PoolConfigUpdateEvent{
            signer_pk                : v1.signer_pk,
            owner                    : v0,
            fee_cut                  : v1.fee_cut,
            fee_cut_creator          : v1.fee_cut_creator,
            fund_addr                : v0,
            expired_ms_support       : v1.expired_ms_support,
            required_cost_in_usd_bps : v1.required_cost_in_usd_bps,
            prevent_spin_early       : v1.prevent_spin_early,
            pool_max_users           : v1.pool_max_users,
            updated_at               : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PoolConfigUpdateEvent>(v2);
        let v3 = PoolExpiredMsSupportEvent{
            expired_ms_support : v1.expired_ms_support,
            updated_at         : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<PoolExpiredMsSupportEvent>(v3);
        0x2::transfer::share_object<PoolConfig>(v1);
    }

    fun initExpiredMsSupport() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::EXPIRED_MS_12H());
        0x1::vector::push_back<u64>(&mut v0, 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::EXPIRED_MS());
        0x1::vector::push_back<u64>(&mut v0, 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant::EXPIRED_MS_48H());
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

    entry fun pauseSystem(arg0: &mut PoolConfig, arg1: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg1, v0), 3);
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

    public fun pool_max_users(arg0: &PoolConfig) : u32 {
        arg0.pool_max_users
    }

    public fun prevent_spin_early(arg0: &PoolConfig) : bool {
        arg0.prevent_spin_early
    }

    public fun removeTimeToJoin(arg0: &mut PoolConfig, arg1: u64, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg0.expired_ms_support, &arg1);
        if (v0) {
            0x1::vector::remove<u64>(&mut arg0.expired_ms_support, v1);
        };
        let v2 = PoolExpiredMsSupportEvent{
            expired_ms_support : arg0.expired_ms_support,
            updated_at         : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolExpiredMsSupportEvent>(v2);
    }

    public fun required_cost_in_usd_bps(arg0: &PoolConfig) : u32 {
        arg0.required_cost_in_usd_bps
    }

    public fun setPoolMaxUser(arg0: &mut PoolConfig, arg1: u32, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.pool_max_users = arg1;
        let v0 = PoolMaxUserUpdateEvent{
            max_user   : arg1,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolMaxUserUpdateEvent>(v0);
    }

    public fun setPreventSpinEarly(arg0: &mut PoolConfig, arg1: bool, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.prevent_spin_early = arg1;
    }

    public fun setRequiredPrice(arg0: &mut PoolConfig, arg1: u32, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.required_cost_in_usd_bps = arg1;
        let v0 = PoolRequiredCostUsdUpdateEvent{
            required_cost_in_usd_bps : arg1,
            updated_at               : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolRequiredCostUsdUpdateEvent>(v0);
    }

    public fun setSignerAddress(arg0: &mut PoolConfig, arg1: vector<u8>, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        arg0.signer_pk = arg1;
        let v0 = PoolSignerUpdateEvent{
            signer_pk  : arg0.signer_pk,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolSignerUpdateEvent>(v0);
    }

    public fun setTimeToJoins(arg0: &mut PoolConfig, arg1: vector<u64>, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg1, v0);
            if (!check_time_to_join_support(arg0, v1)) {
                0x1::vector::push_back<u64>(&mut arg0.expired_ms_support, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = PoolExpiredMsSupportEvent{
            expired_ms_support : arg0.expired_ms_support,
            updated_at         : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PoolExpiredMsSupportEvent>(v2);
    }

    public fun setUseNativeRandom(arg0: &mut PoolConfig, arg1: bool, arg2: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg2, 0x2::tx_context::sender(arg3)), 3);
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

    entry fun unPauseSystem(arg0: &mut PoolConfig, arg1: &0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::Admin, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::permission::is_admin(arg1, v0), 3);
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

