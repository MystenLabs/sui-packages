module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token {
    struct SharedToken<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct SplitJoinRequest<phantom T0> {
        full_amount: u64,
        request: 0x2::token::ActionRequest<T0>,
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

    public fun destroy_zero<T0>(arg0: SharedToken<T0>, arg1: &0x2::tx_context::TxContext) {
        let SharedToken {
            id      : v0,
            balance : v1,
            owner   : v2,
        } = arg0;
        let v3 = v1;
        assert!(0x2::tx_context::sender(arg1) == v2, 3);
        assert!(0x2::balance::value<T0>(&v3) == 0, 4);
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun join<T0>(arg0: &mut SharedToken<T0>, arg1: SharedToken<T0>, arg2: &0x2::tx_context::TxContext) : SplitJoinRequest<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        let v0 = token_value<T0>(arg0);
        join_internal<T0>(arg0, arg1);
        new_split_join_request<T0>(0x2::token::new_request<T0>(join_action(), v0, 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2), token_value<T0>(arg0))
    }

    public fun split<T0>(arg0: &mut SharedToken<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (SharedToken<T0>, SplitJoinRequest<T0>) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = split_internal<T0>(arg0, arg1, arg2);
        let v2 = SplitJoinRequest<T0>{
            full_amount : v0,
            request     : 0x2::token::new_request<T0>(split_action(), arg1, 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2),
        };
        (v1, v2)
    }

    public fun add_approval<T0, T1: drop>(arg0: T1, arg1: &mut SplitJoinRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_approval<T0, T1>(arg0, &mut arg1.request, arg2);
    }

    public fun transfer<T0>(arg0: &mut SharedToken<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 3);
        let v1 = Transferred<T0>{
            previous_owner : v0,
            recipient      : arg1,
            token_id       : 0x2::object::id<SharedToken<T0>>(arg0),
            amount         : token_value<T0>(arg0),
        };
        0x2::event::emit<Transferred<T0>>(v1);
        transfer_internal<T0>(arg0, arg1);
        0x2::token::new_request<T0>(0x2::token::transfer_action(), token_value<T0>(arg0), 0x1::option::some<address>(arg1), 0x1::option::none<0x2::balance::Balance<T0>>(), arg2)
    }

    public fun action_request<T0>(arg0: &SplitJoinRequest<T0>) : &0x2::token::ActionRequest<T0> {
        &arg0.request
    }

    public fun action_request_mut<T0>(arg0: &mut SplitJoinRequest<T0>) : &mut 0x2::token::ActionRequest<T0> {
        &mut arg0.request
    }

    public fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: SharedToken<T0>) {
        let SharedToken {
            id      : v0,
            balance : v1,
            owner   : _,
        } = arg1;
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(arg0), v1);
        0x2::object::delete(v0);
    }

    public fun confirm_split_join_request<T0>(arg0: &0x2::token::TokenPolicy<T0>, arg1: SplitJoinRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64, address, 0x1::option::Option<address>, u64) {
        let SplitJoinRequest {
            full_amount : v0,
            request     : v1,
        } = arg1;
        let (v2, v3, v4, v5) = 0x2::token::confirm_request<T0>(arg0, v1, arg2);
        (v2, v3, v4, v5, v0)
    }

    public fun from_balance_with_policy_cap<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SharedToken<T0> {
        SharedToken<T0>{
            id      : 0x2::object::new(arg3),
            balance : arg1,
            owner   : arg2,
        }
    }

    public fun from_balance_with_treasury_cap<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SharedToken<T0> {
        SharedToken<T0>{
            id      : 0x2::object::new(arg3),
            balance : arg1,
            owner   : arg2,
        }
    }

    public fun from_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (SharedToken<T0>, 0x2::token::ActionRequest<T0>) {
        let v0 = SharedToken<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
            owner   : 0x2::tx_context::sender(arg1),
        };
        (v0, 0x2::token::new_request<T0>(0x2::token::from_coin_action(), 0x2::coin::value<T0>(&arg0), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
    }

    public fun join_action() : 0x1::string::String {
        0x1::string::utf8(b"join")
    }

    fun join_internal<T0>(arg0: &mut SharedToken<T0>, arg1: SharedToken<T0>) {
        let SharedToken {
            id      : v0,
            balance : v1,
            owner   : v2,
        } = arg1;
        assert!(arg0.owner == v2, 1);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
        0x2::object::delete(v0);
    }

    public fun join_with_policy_cap<T0>(arg0: &mut SharedToken<T0>, arg1: SharedToken<T0>, arg2: &0x2::token::TokenPolicyCap<T0>) {
        join_internal<T0>(arg0, arg1);
    }

    public fun join_with_treasury_cap<T0>(arg0: &mut SharedToken<T0>, arg1: SharedToken<T0>, arg2: &0x2::coin::TreasuryCap<T0>) {
        join_internal<T0>(arg0, arg1);
    }

    public fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedToken<T0>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(arg0), arg1),
            owner   : arg2,
        };
        0x2::transfer::share_object<SharedToken<T0>>(v0);
    }

    public fun new_split_join_request<T0>(arg0: 0x2::token::ActionRequest<T0>, arg1: u64) : SplitJoinRequest<T0> {
        assert!(arg1 >= 0x2::token::amount<T0>(&arg0), 2);
        SplitJoinRequest<T0>{
            full_amount : arg1,
            request     : arg0,
        }
    }

    public fun request_action<T0>(arg0: &SplitJoinRequest<T0>) : 0x1::string::String {
        0x2::token::action<T0>(&arg0.request)
    }

    public fun request_amount<T0>(arg0: &SplitJoinRequest<T0>) : u64 {
        0x2::token::amount<T0>(&arg0.request)
    }

    public fun request_approvals<T0>(arg0: &SplitJoinRequest<T0>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        0x2::token::approvals<T0>(&arg0.request)
    }

    public fun request_full_amount<T0>(arg0: &SplitJoinRequest<T0>) : u64 {
        arg0.full_amount
    }

    public fun request_recipient<T0>(arg0: &SplitJoinRequest<T0>) : 0x1::option::Option<address> {
        0x2::token::recipient<T0>(&arg0.request)
    }

    public fun request_sender<T0>(arg0: &SplitJoinRequest<T0>) : address {
        0x2::token::sender<T0>(&arg0.request)
    }

    public fun request_spent<T0>(arg0: &SplitJoinRequest<T0>) : 0x1::option::Option<u64> {
        0x2::token::spent<T0>(&arg0.request)
    }

    public fun share<T0>(arg0: SharedToken<T0>) {
        0x2::transfer::share_object<SharedToken<T0>>(arg0);
    }

    public fun split_action() : 0x1::string::String {
        0x1::string::utf8(b"split")
    }

    fun split_internal<T0>(arg0: &mut SharedToken<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SharedToken<T0> {
        assert!(token_value<T0>(arg0) >= arg1, 0);
        SharedToken<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            owner   : arg0.owner,
        }
    }

    public fun split_with_policy_cap<T0>(arg0: &mut SharedToken<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SharedToken<T0> {
        split_internal<T0>(arg0, arg2, arg3)
    }

    public fun split_with_treasury_cap<T0>(arg0: &mut SharedToken<T0>, arg1: &0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SharedToken<T0> {
        split_internal<T0>(arg0, arg2, arg3)
    }

    public fun to_coin<T0>(arg0: SharedToken<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::token::ActionRequest<T0>) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        let v0 = to_coin_internal<T0>(arg0, arg1);
        (v0, 0x2::token::new_request<T0>(0x2::token::to_coin_action(), 0x2::coin::value<T0>(&v0), 0x1::option::none<address>(), 0x1::option::none<0x2::balance::Balance<T0>>(), arg1))
    }

    fun to_coin_internal<T0>(arg0: SharedToken<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let SharedToken {
            id      : v0,
            balance : v1,
            owner   : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    public fun to_coin_with_policy_cap<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: SharedToken<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        to_coin_internal<T0>(arg1, arg2)
    }

    public fun to_coin_with_treasury_cap<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: SharedToken<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        to_coin_internal<T0>(arg1, arg2)
    }

    public fun token_owner<T0>(arg0: &SharedToken<T0>) : address {
        arg0.owner
    }

    public fun token_value<T0>(arg0: &SharedToken<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun transfer_internal<T0>(arg0: &mut SharedToken<T0>, arg1: address) {
        arg0.owner = arg1;
    }

    public fun transfer_with_policy_cap<T0>(arg0: &0x2::token::TokenPolicyCap<T0>, arg1: &mut SharedToken<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = ForceTransferred<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            token_id : 0x2::object::id<SharedToken<T0>>(arg1),
            from     : token_owner<T0>(arg1),
            to       : arg2,
            amount   : token_value<T0>(arg1),
        };
        0x2::event::emit<ForceTransferred<T0>>(v0);
        transfer_internal<T0>(arg1, arg2);
    }

    public fun transfer_with_treasury_cap<T0>(arg0: &0x2::coin::TreasuryCap<T0>, arg1: &mut SharedToken<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = ForceTransferred<T0>{
            sender   : 0x2::tx_context::sender(arg3),
            token_id : 0x2::object::id<SharedToken<T0>>(arg1),
            from     : token_owner<T0>(arg1),
            to       : arg2,
            amount   : token_value<T0>(arg1),
        };
        0x2::event::emit<ForceTransferred<T0>>(v0);
        transfer_internal<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

