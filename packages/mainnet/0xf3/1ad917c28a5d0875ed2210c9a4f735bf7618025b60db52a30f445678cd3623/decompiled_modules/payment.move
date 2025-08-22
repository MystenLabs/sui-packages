module 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::payment {
    struct Market has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
    }

    struct MembershipPolicy has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_name: 0x1::string::String,
        discount_rate: u64,
        reward_ticket: 0x1::string::String,
        reward_value: u64,
        is_active: bool,
    }

    struct MembershipPolicyKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        membership_name: 0x1::string::String,
    }

    struct RewardKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        ticket_name: 0x1::string::String,
    }

    struct TokenKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun deposit<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>) {
        ensure_balance<T0>(arg0);
        let v0 = TokenKey<T0>{dummy_field: false};
        0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
    }

    fun ensure_balance<T0>(arg0: &mut Market) {
        let v0 = TokenKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TokenKey<T0>>(&arg0.id, v0)) {
            let v1 = TokenKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
    }

    public fun new_market(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::MarketManager>(arg0, 0x2::tx_context::sender(arg1)), 1);
        let v0 = Market{
            id           : 0x2::object::new(arg1),
            community_id : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
        };
        0x2::transfer::share_object<Market>(v0);
    }

    public fun new_membership_policy(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut Market, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::MarketManager>(arg0, 0x2::tx_context::sender(arg7)), 1);
        let v1 = MembershipPolicyKey<MembershipPolicy>{
            community_id    : v0,
            membership_name : arg2,
        };
        assert!(!0x2::dynamic_field::exists_<MembershipPolicyKey<MembershipPolicy>>(&arg1.id, v1), 13906834453516255231);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::check_ticket_type(arg0, arg4), 2);
        let v2 = MembershipPolicyKey<MembershipPolicy>{
            community_id    : v0,
            membership_name : arg2,
        };
        let v3 = MembershipPolicy{
            community_id    : v0,
            membership_name : arg2,
            discount_rate   : arg3,
            reward_ticket   : arg4,
            reward_value    : arg5,
            is_active       : arg6,
        };
        0x2::dynamic_field::add<MembershipPolicyKey<MembershipPolicy>, MembershipPolicy>(&mut arg1.id, v2, v3);
    }

    public fun process_payment_with_membership<T0>(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut Market, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::Membership, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        let v1 = 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_membership_name(arg4);
        let v2 = MembershipPolicyKey<MembershipPolicy>{
            community_id    : v0,
            membership_name : v1,
        };
        if (0x2::dynamic_field::exists_<MembershipPolicyKey<MembershipPolicy>>(&arg1.id, v2)) {
            let v3 = MembershipPolicyKey<MembershipPolicy>{
                community_id    : v0,
                membership_name : v1,
            };
            let v4 = 0x2::dynamic_field::borrow<MembershipPolicyKey<MembershipPolicy>, MembershipPolicy>(&arg1.id, v3);
            if (v4.is_active) {
                let v5 = v4.discount_rate;
                let v6 = v4.reward_ticket;
                if (v6 != 0x1::string::utf8(b"")) {
                    let v7 = RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>{
                        community_id : v0,
                        ticket_name  : v6,
                    };
                    if (0x2::dynamic_field::exists_<RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg4), v7)) {
                        let v8 = RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>{
                            community_id : v0,
                            ticket_name  : v6,
                        };
                        0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::add_ticket_value(0x2::dynamic_field::borrow_mut<RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>, 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::Ticket>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg4), v8), v4.reward_value);
                    } else {
                        let v9 = RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>{
                            community_id : v0,
                            ticket_name  : v6,
                        };
                        0x2::dynamic_field::add<RewardKey<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::TicketType>, 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::Ticket>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::exclusuive_membership::get_mut_uid_membership(arg4), v9, 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::new_ticket(v6, v4.reward_value));
                    };
                };
                let v10 = if (v5 > 0) {
                    arg3 * (10000 - v5) / 10000
                } else {
                    arg3
                };
                deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, v10, arg5));
            } else {
                deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, arg3, arg5));
            };
        } else {
            deposit<T0>(arg1, 0x2::coin::split<T0>(arg2, arg3, arg5));
        };
    }

    public fun process_payment_without_membership<T0>(arg0: &mut Market, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg2, arg3));
    }

    public fun update_membership_policy(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut Market, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::MarketManager>(arg0, 0x2::tx_context::sender(arg7)), 1);
        let v1 = MembershipPolicyKey<MembershipPolicy>{
            community_id    : v0,
            membership_name : arg2,
        };
        assert!(0x2::dynamic_field::exists_<MembershipPolicyKey<MembershipPolicy>>(&arg1.id, v1), 13906834603840110591);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward::check_ticket_type(arg0, arg4), 2);
        let v2 = MembershipPolicyKey<MembershipPolicy>{
            community_id    : v0,
            membership_name : arg2,
        };
        let v3 = 0x2::dynamic_field::borrow_mut<MembershipPolicyKey<MembershipPolicy>, MembershipPolicy>(&mut arg1.id, v2);
        v3.discount_rate = arg3;
        v3.reward_ticket = arg4;
        v3.reward_value = arg5;
        v3.is_active = arg6;
    }

    public fun withdraw<T0>(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: &mut Market, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::MarketManager>(arg0, 0x2::tx_context::sender(arg2)), 1);
        ensure_balance<T0>(arg1);
        let v0 = TokenKey<T0>{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v0)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

