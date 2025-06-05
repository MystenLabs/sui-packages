module 0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::points_management {
    struct WitnessRule has drop {
        dummy_field: bool,
    }

    struct PointsSpentActionRequest<phantom T0> {
        reason: 0x1::string::String,
        action_request: 0x2::token::ActionRequest<T0>,
    }

    struct PointTicket<phantom T0> has key {
        id: 0x2::object::UID,
        amount: u64,
        reason: 0x1::string::String,
    }

    struct CapRegistry<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::borrow::Referent<0x2::coin::TreasuryCap<T0>>,
        token_policy_cap: 0x2::borrow::Referent<0x2::token::TokenPolicyCap<T0>>,
    }

    struct PointTicketRedeemed<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct PointTicketMinted<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        reason: 0x1::string::String,
    }

    struct TokenMintedFromAdmin<phantom T0> has copy, drop {
        amount: u64,
        recipient: address,
        reason: 0x1::string::String,
    }

    struct PointsSpent<phantom T0> has copy, drop {
        amount: u64,
        sender: address,
        reason: 0x1::string::String,
    }

    public(friend) fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg5)), arg6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    public fun add_approval<T0, T1: drop>(arg0: T1, arg1: &mut PointsSpentActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_approval<T0, T1>(arg0, &mut arg1.action_request, arg2);
    }

    public fun mint<T0>(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: &mut CapRegistry<T0>, arg2: u64, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg5));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        let v0 = TokenMintedFromAdmin<T0>{
            amount    : arg2,
            recipient : arg3,
            reason    : arg4,
        };
        let (v1, v2) = 0x2::borrow::borrow<0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_cap);
        let v3 = v1;
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut v3, 0x2::token::transfer<T0>(0x2::token::mint<T0>(&mut v3, arg2, arg5), arg3, arg5), arg5);
        0x2::borrow::put_back<0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_cap, v3, v2);
        0x2::event::emit<TokenMintedFromAdmin<T0>>(v0);
    }

    public fun spend<T0>(arg0: 0x2::token::Token<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : PointsSpentActionRequest<T0> {
        let v0 = 0x2::token::spend<T0>(arg0, arg2);
        let v1 = WitnessRule{dummy_field: false};
        0x2::token::add_approval<T0, WitnessRule>(v1, &mut v0, arg2);
        let v2 = PointsSpent<T0>{
            amount : 0x2::token::amount<T0>(&v0),
            sender : 0x2::token::sender<T0>(&v0),
            reason : arg1,
        };
        0x2::event::emit<PointsSpent<T0>>(v2);
        PointsSpentActionRequest<T0>{
            reason         : arg1,
            action_request : v0,
        }
    }

    public fun add_witness_rule<T0>(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: &mut CapRegistry<T0>, arg2: &mut 0x2::token::TokenPolicy<T0>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg4));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        let (v0, v1) = 0x2::borrow::borrow<0x2::token::TokenPolicyCap<T0>>(&mut arg1.token_policy_cap);
        let v2 = v0;
        0x2::token::add_rule_for_action<T0, WitnessRule>(arg2, &v2, arg3, arg4);
        0x2::borrow::put_back<0x2::token::TokenPolicyCap<T0>>(&mut arg1.token_policy_cap, v2, v1);
    }

    public fun borrow_token_policy_cap<T0>(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: &mut CapRegistry<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::token::TokenPolicyCap<T0>, 0x2::borrow::Borrow) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg2));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        0x2::borrow::borrow<0x2::token::TokenPolicyCap<T0>>(&mut arg1.token_policy_cap)
    }

    public fun borrow_treasury_cap<T0>(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: &mut CapRegistry<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::borrow::Borrow) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg2));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        0x2::borrow::borrow<0x2::coin::TreasuryCap<T0>>(&mut arg1.treasury_cap)
    }

    public fun confirm_spend_request<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: PointsSpentActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let PointsSpentActionRequest {
            reason         : _,
            action_request : v1,
        } = arg1;
        let (_, _, _, _) = 0x2::token::confirm_request_mut<T0>(arg0, v1, arg2);
    }

    public(friend) fun create_registry<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CapRegistry<T0>{
            id               : 0x2::object::new(arg2),
            treasury_cap     : 0x2::borrow::new<0x2::coin::TreasuryCap<T0>>(arg0, arg2),
            token_policy_cap : 0x2::borrow::new<0x2::token::TokenPolicyCap<T0>>(arg1, arg2),
        };
        0x2::transfer::share_object<CapRegistry<T0>>(v0);
    }

    public fun get_action<T0>(arg0: &PointsSpentActionRequest<T0>) : 0x1::string::String {
        0x2::token::action<T0>(&arg0.action_request)
    }

    public fun get_amount<T0>(arg0: &PointsSpentActionRequest<T0>) : u64 {
        0x2::token::amount<T0>(&arg0.action_request)
    }

    public fun get_reason<T0>(arg0: &PointsSpentActionRequest<T0>) : 0x1::string::String {
        arg0.reason
    }

    public fun mint_point_ticket_as_admin<T0>(arg0: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_admin(arg0, 0x2::tx_context::sender(arg4));
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg0);
        let v0 = 0x2::object::new(arg4);
        let v1 = PointTicketMinted<T0>{
            ticket_id : 0x2::object::uid_to_inner(&v0),
            amount    : arg1,
            recipient : arg2,
            reason    : arg3,
        };
        let v2 = PointTicket<T0>{
            id     : v0,
            amount : arg1,
            reason : arg3,
        };
        0x2::transfer::transfer<PointTicket<T0>>(v2, arg2);
        0x2::event::emit<PointTicketMinted<T0>>(v1);
    }

    public fun redeem_point_ticket<T0>(arg0: PointTicket<T0>, arg1: &0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::MoviePassRegistry, arg2: &mut CapRegistry<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x3fdf3a2f80c11b593d1c3e90c698be106714745c666cdc269182d3f9b21af564::core::check_valid_version(arg1);
        let PointTicket {
            id     : v0,
            amount : v1,
            reason : _,
        } = arg0;
        let v3 = v0;
        let v4 = PointTicketRedeemed<T0>{
            ticket_id : 0x2::object::uid_to_inner(&v3),
            amount    : v1,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::object::delete(v3);
        let (v5, v6) = 0x2::borrow::borrow<0x2::coin::TreasuryCap<T0>>(&mut arg2.treasury_cap);
        let v7 = v5;
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut v7, 0x2::token::transfer<T0>(0x2::token::mint<T0>(&mut v7, v1, arg3), 0x2::tx_context::sender(arg3), arg3), arg3);
        0x2::borrow::put_back<0x2::coin::TreasuryCap<T0>>(&mut arg2.treasury_cap, v7, v6);
        0x2::event::emit<PointTicketRedeemed<T0>>(v4);
    }

    public fun return_token_policy_cap<T0>(arg0: &mut CapRegistry<T0>, arg1: 0x2::token::TokenPolicyCap<T0>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::token::TokenPolicyCap<T0>>(&mut arg0.token_policy_cap, arg1, arg2);
    }

    public fun return_treasury_cap<T0>(arg0: &mut CapRegistry<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap, arg1, arg2);
    }

    public fun ticket_amount<T0>(arg0: &PointTicket<T0>) : u64 {
        arg0.amount
    }

    // decompiled from Move bytecode v6
}

