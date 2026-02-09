module 0x91f2fdf66111c9eada5c6c17a360ea3a1bf6e54e72c4589b0b10279627cc6371::auth {
    struct Authorization has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        token_type: 0x1::string::String,
        daily_limit: u64,
        per_tx_limit: u64,
        used_today: u64,
        last_reset: u64,
        expiry: u64,
        enabled: bool,
    }

    struct AuthRecord has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        amount: u64,
        timestamp: u64,
    }

    struct AuthCreated has copy, drop {
        owner: address,
        daily_limit: u64,
        per_tx_limit: u64,
        expiry: u64,
    }

    struct AuthUsed has copy, drop {
        owner: address,
        amount: u64,
        used_today: u64,
        timestamp: u64,
    }

    public fun can_execute(arg0: &Authorization, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        if (!arg0.enabled) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 > arg0.expiry) {
            return false
        };
        if (arg1 > arg0.per_tx_limit) {
            return false
        };
        let v1 = if ((v0 - arg0.last_reset) / 86400 > 0) {
            0
        } else {
            arg0.used_today
        };
        v1 + arg1 <= arg0.daily_limit
    }

    public entry fun create_authorization(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5) / 1000;
        let v2 = v1 + arg4 * 24 * 3600;
        let v3 = Authorization{
            id           : 0x2::object::new(arg5),
            owner        : v0,
            agent        : arg0,
            token_type   : arg1,
            daily_limit  : arg2,
            per_tx_limit : arg3,
            used_today   : 0,
            last_reset   : v1,
            expiry       : v2,
            enabled      : true,
        };
        0x2::transfer::share_object<Authorization>(v3);
        let v4 = AuthCreated{
            owner        : v0,
            daily_limit  : arg2,
            per_tx_limit : arg3,
            expiry       : v2,
        };
        0x2::event::emit<AuthCreated>(v4);
    }

    public entry fun disable_authorization(arg0: &mut Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 5);
        arg0.enabled = false;
    }

    public entry fun enable_authorization(arg0: &mut Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 5);
        arg0.enabled = true;
    }

    public entry fun execute_with_auth(arg0: &mut Authorization, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 <= arg0.expiry, 2);
        assert!(arg2 <= arg0.per_tx_limit, 1);
        assert!(arg2 > 0, 4);
        if ((v0 - arg0.last_reset) / 86400 > 0) {
            arg0.used_today = 0;
            arg0.last_reset = v0;
        };
        let v1 = arg0.used_today + arg2;
        assert!(v1 <= arg0.daily_limit, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg2, arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.owner);
        arg0.used_today = v1;
        let v2 = AuthUsed{
            owner      : arg0.owner,
            amount     : arg2,
            used_today : arg0.used_today,
            timestamp  : v0,
        };
        0x2::event::emit<AuthUsed>(v2);
        let v3 = AuthRecord{
            id        : 0x2::object::new(arg5),
            owner     : arg0.owner,
            agent     : arg0.agent,
            amount    : arg2,
            timestamp : v0,
        };
        0x2::transfer::transfer<AuthRecord>(v3, arg0.owner);
    }

    public fun get_auth_status(arg0: &Authorization) : (bool, u64, u64, u64, u64, u64) {
        (arg0.enabled, arg0.daily_limit, arg0.per_tx_limit, arg0.used_today, arg0.last_reset, arg0.expiry)
    }

    public entry fun increase_daily_limit(arg0: &mut Authorization, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        arg0.daily_limit = arg0.daily_limit + arg1;
    }

    public entry fun revoke_authorization(arg0: Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 5);
        let Authorization {
            id           : v0,
            owner        : _,
            agent        : _,
            token_type   : _,
            daily_limit  : _,
            per_tx_limit : _,
            used_today   : _,
            last_reset   : _,
            expiry       : _,
            enabled      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

