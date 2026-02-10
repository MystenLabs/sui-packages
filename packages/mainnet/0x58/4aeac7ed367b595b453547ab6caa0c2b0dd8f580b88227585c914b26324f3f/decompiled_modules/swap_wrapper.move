module 0x3b7651cb9af66977c4a0404bc1eb5f198432294d55c9f6114e71710d9db491a2::swap_wrapper {
    struct Authorization has store, key {
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

    struct SwapExecuted has copy, drop {
        owner: address,
        input_token: 0x1::string::String,
        output_token: 0x1::string::String,
        input_amount: u64,
        output_amount: u64,
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

    public entry fun create_test_authorization(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg5) / 1000;
        let v1 = Authorization{
            id           : 0x2::object::new(arg5),
            owner        : 0x2::tx_context::sender(arg5),
            agent        : arg0,
            token_type   : arg1,
            daily_limit  : arg2,
            per_tx_limit : arg3,
            used_today   : 0,
            last_reset   : v0,
            expiry       : v0 + arg4 * 24 * 3600,
            enabled      : true,
        };
        0x2::transfer::public_share_object<Authorization>(v1);
    }

    public fun disable_authorization(arg0: &mut Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 7);
        arg0.enabled = false;
    }

    public fun enable_authorization(arg0: &mut Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 7);
        arg0.enabled = true;
    }

    public fun execute_swap_with_auth(arg0: &mut Authorization, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(arg0.enabled == true, 3);
        assert!(v0 <= arg0.expiry, 2);
        assert!(arg0.agent == 0x2::tx_context::sender(arg4) || arg0.owner == 0x2::tx_context::sender(arg4), 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 4);
        assert!(v1 <= arg0.per_tx_limit, 1);
        if ((v0 - arg0.last_reset) / 86400 > 0) {
            arg0.used_today = 0;
            arg0.last_reset = v0;
        };
        let v2 = arg0.used_today + v1;
        assert!(v2 <= arg0.daily_limit, 1);
        arg0.used_today = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        let v3 = SwapExecuted{
            owner         : arg0.owner,
            input_token   : arg0.token_type,
            output_token  : 0x1::string::utf8(b"SUI"),
            input_amount  : v1,
            output_amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            timestamp     : v0,
        };
        0x2::event::emit<SwapExecuted>(v3);
    }

    public fun get_auth_status(arg0: &Authorization) : (bool, u64, u64, u64, u64, u64) {
        (arg0.enabled, arg0.daily_limit, arg0.per_tx_limit, arg0.used_today, arg0.last_reset, arg0.expiry)
    }

    public fun revoke_authorization_internal(arg0: &mut Authorization, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 7);
        arg0.enabled = false;
    }

    // decompiled from Move bytecode v6
}

