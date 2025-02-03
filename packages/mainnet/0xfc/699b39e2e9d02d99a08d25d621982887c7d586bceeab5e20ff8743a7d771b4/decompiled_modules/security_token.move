module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::security_token {
    struct SecurityToken<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct Transferred<phantom T0> has copy, drop {
        previous_owner: address,
        recipient: address,
        token_id: 0x2::object::ID,
        amount: u64,
    }

    struct ForceTransferred<phantom T0> has copy, drop {
        sender: address,
        token_id: 0x2::object::ID,
        from: address,
        to: address,
        amount: u64,
    }

    struct Minted<phantom T0> has copy, drop {
        owner: address,
        token_id: 0x2::object::ID,
        amount: u64,
    }

    struct Burned<phantom T0> has copy, drop {
        owner: address,
        token_id: 0x2::object::ID,
        amount: u64,
    }

    public fun destroy_zero<T0>(arg0: SecurityToken<T0>, arg1: &0x2::tx_context::TxContext) {
        let SecurityToken {
            id      : v0,
            balance : v1,
            owner   : v2,
        } = arg0;
        let v3 = v1;
        assert!(0x2::tx_context::sender(arg1) == v2, 9223372573725949957);
        assert!(0x2::balance::value<T0>(&v3) == 0, 9223372578021048327);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun join<T0>(arg0: &mut SecurityToken<T0>, arg1: SecurityToken<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 9223372526481309701);
        join_internal<T0>(arg0, arg1);
    }

    public fun split<T0>(arg0: &mut SecurityToken<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SecurityToken<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 9223372496416538629);
        split_internal<T0>(arg0, arg1, arg2)
    }

    public fun transfer<T0>(arg0: &mut SecurityToken<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 9223372414812160005);
        transfer_internal<T0>(arg0, arg1);
        0x2::token::new_request<T0>(0x2::token::transfer_action(), token_value<T0>(arg0), 0x1::option::some<address>(arg1), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2)
    }

    public fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::object::ID, arg2: SecurityToken<T0>) {
        let SecurityToken {
            id      : v0,
            balance : v1,
            owner   : v2,
        } = arg2;
        let v3 = v1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), v3);
        let v4 = Burned<T0>{
            owner    : v2,
            token_id : arg1,
            amount   : 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<Burned<T0>>(v4);
        0x2::object::delete(v0);
    }

    fun join_internal<T0>(arg0: &mut SecurityToken<T0>, arg1: SecurityToken<T0>) {
        let SecurityToken {
            id      : v0,
            balance : v1,
            owner   : v2,
        } = arg1;
        assert!(arg0.owner == v2, 9223373273805488131);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
    }

    public fun join_with_policy_cap<T0>(arg0: &mut SecurityToken<T0>, arg1: SecurityToken<T0>, arg2: &0x2::token::TokenPolicyCap<T0>) {
        join_internal<T0>(arg0, arg1);
    }

    public fun join_with_treasury_cap<T0>(arg0: &mut SecurityToken<T0>, arg1: SecurityToken<T0>, arg2: &0x2::coin::TreasuryCap<T0>) {
        join_internal<T0>(arg0, arg1);
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SecurityToken<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(arg0), arg1),
            owner   : arg2,
        };
        let v1 = Minted<T0>{
            owner    : arg2,
            token_id : 0x2::object::id<SecurityToken<T0>>(&v0),
            amount   : arg1,
        };
        0x2::event::emit<Minted<T0>>(v1);
        0x2::transfer::share_object<SecurityToken<T0>>(v0);
    }

    public fun share<T0>(arg0: SecurityToken<T0>) {
        0x2::transfer::share_object<SecurityToken<T0>>(arg0);
    }

    fun split_internal<T0>(arg0: &mut SecurityToken<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SecurityToken<T0> {
        assert!(token_value<T0>(arg0) >= arg1, 9223373239445618689);
        SecurityToken<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            owner   : arg0.owner,
        }
    }

    public fun split_with_policy_cap<T0>(arg0: &mut SecurityToken<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SecurityToken<T0> {
        split_internal<T0>(arg0, arg2, arg3)
    }

    public fun split_with_treasury_cap<T0>(arg0: &mut SecurityToken<T0>, arg1: &0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SecurityToken<T0> {
        split_internal<T0>(arg0, arg2, arg3)
    }

    public fun token_owner<T0>(arg0: &SecurityToken<T0>) : address {
        arg0.owner
    }

    public fun token_value<T0>(arg0: &SecurityToken<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun transfer_internal<T0>(arg0: &mut SecurityToken<T0>, arg1: address) {
        let v0 = Transferred<T0>{
            previous_owner : arg0.owner,
            recipient      : arg1,
            token_id       : 0x2::object::id<SecurityToken<T0>>(arg0),
            amount         : token_value<T0>(arg0),
        };
        0x2::event::emit<Transferred<T0>>(v0);
        arg0.owner = arg1;
    }

    public fun transfer_with_policy_cap<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut SecurityToken<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = ForceTransferred<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            token_id : 0x2::object::id<SecurityToken<T0>>(arg1),
            from     : token_owner<T0>(arg1),
            to       : arg2,
            amount   : token_value<T0>(arg1),
        };
        0x2::event::emit<ForceTransferred<T0>>(v0);
        transfer_internal<T0>(arg1, arg2);
    }

    public fun transfer_with_treasury_cap<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut SecurityToken<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = ForceTransferred<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            token_id : 0x2::object::id<SecurityToken<T0>>(arg1),
            from     : token_owner<T0>(arg1),
            to       : arg2,
            amount   : token_value<T0>(arg1),
        };
        0x2::event::emit<ForceTransferred<T0>>(v0);
        transfer_internal<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

