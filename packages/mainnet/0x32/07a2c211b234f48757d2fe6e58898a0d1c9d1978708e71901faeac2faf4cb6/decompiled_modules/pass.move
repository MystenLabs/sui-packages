module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::pass {
    struct PASS has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentPass has key {
        id: 0x2::object::UID,
        control: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::Control,
    }

    struct AgentKey has copy, drop, store {
        pos0: address,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        pass: 0x2::object::ID,
        name: 0x1::ascii::String,
    }

    struct Created has copy, drop {
        pass: 0x2::object::ID,
        receipt: 0x2::object::ID,
        name: 0x1::ascii::String,
        owner: address,
        agent: address,
        agent_expires_ms: u64,
    }

    struct Issued has copy, drop {
        pass: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        lifetime_cap: 0x1::option::Option<u256>,
        expires_ms: 0x1::option::Option<u64>,
    }

    struct ObjectDeposited has copy, drop {
        pass: 0x2::object::ID,
        key: 0x1::type_name::TypeName,
        object: 0x2::object::ID,
        object_type: 0x1::type_name::TypeName,
    }

    struct ObjectWithdrawn has copy, drop {
        pass: 0x2::object::ID,
        key: 0x1::type_name::TypeName,
        object: 0x2::object::ID,
        object_type: 0x1::type_name::TypeName,
    }

    struct Destroyed has copy, drop {
        pass: 0x2::object::ID,
    }

    struct Migrated has copy, drop {
        version: u64,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    struct Swap<phantom T0, phantom T1, phantom T2> {
        controller: 0x2::object::ID,
        pending: 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::Pending<T0, T1>,
        funds: 0x2::balance::Balance<T2>,
        rest: 0x2::balance::Balance<T0>,
        out: 0x2::balance::Balance<T1>,
        spent: u64,
        hops: u8,
    }

    struct Loan<phantom T0, phantom T1> {
        venue: 0x2::object::ID,
    }

    public fun issue<T0>(arg0: &AgentPass, arg1: &Config, arg2: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_owner(&arg0.control, arg3);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg2);
        assert!(matches(arg0, v0), 0);
        let v1 = 0x2::allowance::expiration_timestamp_ms(v0);
        assert!(0x1::option::is_some<u64>(&v1) && *0x1::option::borrow<u64>(&v1) <= 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::agent_expires_ms(&arg0.control), 0);
        let v2 = Issued{
            pass         : 0x2::object::uid_to_inner(&arg0.id),
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            lifetime_cap : 0x2::allowance::lifetime_cap(v0),
            expires_ms   : v1,
        };
        0x2::event::emit<Issued>(v2);
        0x2::allowance::issue<0x2::balance::Balance<T0>, PASS>(arg2, 0x2::allowance::settings_permit<PASS>(0x1::internal::permit<PASS>()), arg3);
    }

    public fun split<T0, T1>(arg0: Swap<T0, T1, T0>, arg1: u64) : Swap<T0, T1, T0> {
        let Swap {
            controller : v0,
            pending    : v1,
            funds      : v2,
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : v6,
        } = arg0;
        let v7 = v3;
        let v8 = v2;
        assert!(v6 == 0, 8);
        0x2::balance::join<T0>(&mut v7, v8);
        Swap<T0, T1, T0>{
            controller : v0,
            pending    : v1,
            funds      : 0x2::balance::split<T0>(&mut v8, arg1),
            rest       : v7,
            out        : v4,
            spent      : v5,
            hops       : v6,
        }
    }

    public(friend) entry fun transfer<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: 0x1::ascii::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        let v0 = spend<T0>(arg0, arg2, arg3, arg5, arg6);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::transfer_policy::execute<T0>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow_mut<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::transfer_policy::TransferPolicy<T0>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies_mut(&mut arg0.control)), 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::controller(&arg0.control), v0, arg4, arg5);
    }

    public fun control(arg0: &AgentPass) : &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::Control {
        &arg0.control
    }

    public fun add_policy<T0: store>(arg0: &mut AgentPass, arg1: &Config, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::add_policy<T0>(&mut arg0.control, arg2, arg3);
    }

    public(friend) entry fun destroy(arg0: AgentPass, arg1: &0x2::tx_context::TxContext) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_owner(&arg0.control, arg1);
        assert!(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::length(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies(&arg0.control)) == 0 && 0x2::bag::is_empty(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::positions(&arg0.control)), 4);
        let v0 = Destroyed{pass: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<Destroyed>(v0);
        let AgentPass {
            id      : v1,
            control : v2,
        } = arg0;
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::destroy(v2);
        0x2::object::delete(v1);
    }

    public fun remove_policy<T0: store>(arg0: &mut AgentPass, arg1: &0x2::tx_context::TxContext) : T0 {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::remove_policy<T0>(&mut arg0.control, arg1)
    }

    public(friend) entry fun resign(arg0: &mut AgentPass, arg1: &0x2::tx_context::TxContext) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::resign(&mut arg0.control, arg1);
    }

    public(friend) entry fun revoke_agent(arg0: &mut AgentPass, arg1: &0x2::tx_context::TxContext) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::revoke_agent(&mut arg0.control, arg1);
    }

    public(friend) entry fun set_term(arg0: &mut AgentPass, arg1: &Config, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::set_term(&mut arg0.control, arg2, arg3, arg4);
    }

    public fun repay<T0: drop, T1, T2, T3, T4>(arg0: &AgentPass, arg1: Swap<T1, T2, T3>, arg2: Loan<T0, T3>, arg3: 0x2::balance::Balance<T3>, arg4: 0x2::balance::Balance<T4>, arg5: T0) : Swap<T1, T2, T4> {
        let Swap {
            controller : v0,
            pending    : v1,
            funds      : v2,
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : v6,
        } = arg1;
        let v7 = v1;
        assert!(v0 == 0x2::object::id<AgentPass>(arg0), 7);
        let Loan { venue: v8 } = arg2;
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::record<T1, T2>(&mut v7, v8);
        0x2::balance::destroy_zero<T3>(v2);
        let v9 = if (v6 == 0) {
            v5 - 0x2::balance::value<T3>(&arg3)
        } else {
            v5
        };
        keep<T3>(arg0, arg3);
        Swap<T1, T2, T4>{
            controller : v0,
            pending    : v7,
            funds      : arg4,
            rest       : v3,
            out        : v4,
            spent      : v9,
            hops       : v6 + 1,
        }
    }

    fun assert_live(arg0: &Config) {
        assert!(arg0.version == 1, 5);
        assert!(!arg0.paused, 6);
    }

    public fun begin_swap<T0, T1>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : Swap<T0, T1, T0> {
        assert_live(arg1);
        let v0 = spend<T0>(arg0, arg2, arg3, arg4, arg5);
        let v1 = 0x2::balance::value<T0>(&v0);
        Swap<T0, T1, T0>{
            controller : 0x2::object::id<AgentPass>(arg0),
            pending    : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::begin<T0, T1>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow_mut<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::SwapPolicy<T0, T1>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies_mut(&mut arg0.control)), v1, arg4),
            funds      : v0,
            rest       : 0x2::balance::zero<T0>(),
            out        : 0x2::balance::zero<T1>(),
            spent      : v1,
            hops       : 0,
        }
    }

    public(friend) entry fun burn_receipt(arg0: Receipt) {
        let Receipt {
            id   : v0,
            pass : _,
            name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AgentPass {
        assert_live(arg0);
        let v0 = AgentKey{pos0: arg2};
        let v1 = 0x2::derived_object::claim<AgentKey>(&mut arg0.id, v0);
        let v2 = Receipt{
            id   : 0x2::object::new(arg5),
            pass : 0x2::object::uid_to_inner(&v1),
            name : arg1,
        };
        let v3 = Created{
            pass             : 0x2::object::uid_to_inner(&v1),
            receipt          : 0x2::object::id<Receipt>(&v2),
            name             : arg1,
            owner            : 0x2::tx_context::sender(arg5),
            agent            : arg2,
            agent_expires_ms : arg3,
        };
        0x2::event::emit<Created>(v3);
        0x2::transfer::transfer<Receipt>(v2, 0x2::tx_context::sender(arg5));
        AgentPass{
            id      : v1,
            control : 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::new(0x2::object::uid_to_inner(&v1), arg1, arg2, arg3, arg4, arg5),
        }
    }

    public fun deposit_object<T0: copy + drop + store, T1: store + key>(arg0: &mut AgentPass, arg1: &Config, arg2: T0, arg3: T1, arg4: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        let v0 = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::edit_positions(&mut arg0.control, arg4);
        assert!(!0x2::bag::contains<T0>(v0, arg2), 3);
        let v1 = ObjectDeposited{
            pass        : 0x2::object::uid_to_inner(&arg0.id),
            key         : 0x1::type_name::with_defining_ids<T0>(),
            object      : 0x2::object::id<T1>(&arg3),
            object_type : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<ObjectDeposited>(v1);
        0x2::bag::add<T0, T1>(v0, arg2, arg3);
    }

    fun end_swap<T0, T1>(arg0: &mut AgentPass, arg1: Swap<T0, T1, T1>, arg2: u64) : (u64, u64) {
        let Swap {
            controller : v0,
            pending    : v1,
            funds      : v2,
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : _,
        } = arg1;
        let v7 = v4;
        let v8 = v3;
        assert!(v0 == 0x2::object::id<AgentPass>(arg0), 7);
        0x2::balance::join<T1>(&mut v7, v2);
        let v9 = v5 - 0x2::balance::value<T0>(&v8);
        let v10 = 0x2::balance::value<T1>(&v7);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::daily_cap::refund<T0>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow_mut<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::daily_cap::DailyCap<T0>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies_mut(&mut arg0.control)), 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::finish<T0, T1>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow_mut<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::SwapPolicy<T0, T1>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies_mut(&mut arg0.control)), v1, v0, v9, v10, arg2));
        keep<T0>(arg0, v8);
        keep<T1>(arg0, v7);
        (v9, v10)
    }

    public fun finish_swap<T0, T1>(arg0: &mut AgentPass, arg1: Swap<T0, T1, T1>, arg2: u64) {
        assert!(!0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::contains<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::MarketBound<T0, T1>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies(&arg0.control)), 9);
        let (_, _) = end_swap<T0, T1>(arg0, arg1, arg2);
    }

    public fun finish_swap_at_market<T0, T1>(arg0: &mut AgentPass, arg1: Swap<T0, T1, T1>, arg2: u64, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &0x2::clock::Clock) {
        let (v0, v1) = end_swap<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::MarketBound<T0, T1>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies(&arg0.control));
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::assert_oracle<T0, T1>(v2, 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg3));
        let (v3, v4) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi_oracle::price(arg3, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::feed_in<T0, T1>(v2), arg4);
        let (v5, v6) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi_oracle::price(arg3, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::feed_out<T0, T1>(v2), arg4);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::market_bound::check<T0, T1>(v2, v0, v1, v3, v4, v5, v6);
    }

    fun init(arg0: PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg1),
            version : 1,
            paused  : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun keep<T0>(arg0: &AgentPass, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::send_funds<T0>(arg1, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::owner(&arg0.control));
        };
    }

    public fun lend<T0: drop, T1, T2, T3>(arg0: &AgentPass, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg2: Swap<T1, T2, T3>, arg3: 0x2::object::ID, arg4: T0) : (Swap<T1, T2, T3>, 0x2::balance::Balance<T3>, Loan<T0, T3>) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::assert_interface(arg1);
        let Swap {
            controller : v0,
            pending    : v1,
            funds      : v2,
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : v6,
        } = arg2;
        assert!(v0 == 0x2::object::id<AgentPass>(arg0), 7);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::admit<T1, T2>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::swap_policy::SwapPolicy<T1, T2>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies(&arg0.control)), 0x1::type_name::with_defining_ids<T0>(), 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::exchange_version<T0>(arg1), arg3);
        let v7 = Swap<T1, T2, T3>{
            controller : v0,
            pending    : v1,
            funds      : 0x2::balance::zero<T3>(),
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : v6,
        };
        let v8 = Loan<T0, T3>{venue: arg3};
        (v7, v2, v8)
    }

    fun matches(arg0: &AgentPass, arg1: &0x2::allowance::Settings) : bool {
        if (0x2::allowance::funder(arg1) == 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::owner(&arg0.control)) {
            let v1 = 0x2::allowance::spender(arg1);
            let v2 = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::agent(&arg0.control);
            0x1::option::contains<address>(&v1, &v2)
        } else {
            false
        }
    }

    public fun merge<T0, T1>(arg0: Swap<T0, T1, T1>) : Swap<T0, T1, T0> {
        let Swap {
            controller : v0,
            pending    : v1,
            funds      : v2,
            rest       : v3,
            out        : v4,
            spent      : v5,
            hops       : _,
        } = arg0;
        let v7 = v4;
        0x2::balance::join<T1>(&mut v7, v2);
        Swap<T0, T1, T0>{
            controller : v0,
            pending    : v1,
            funds      : v3,
            rest       : 0x2::balance::zero<T0>(),
            out        : v7,
            spent      : v5,
            hops       : 0,
        }
    }

    public(friend) entry fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
        let v0 = Migrated{version: 1};
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) entry fun migrate_interface(arg0: &mut 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg1: &AdminCap) {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::migrate_interface(arg0);
    }

    public(friend) entry fun navi_borrow<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_agent(&arg0.control, arg10, arg11);
        keep<T0>(arg0, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi::borrow<T0>(&mut arg0.control, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun navi_open(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_owner(&arg0.control, arg2);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi::open(&mut arg0.control, arg2);
    }

    public(friend) entry fun navi_repay<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        let v0 = spend<T0>(arg0, arg2, arg3, arg10, arg11);
        keep<T0>(arg0, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi::repay<T0>(&mut arg0.control, arg4, arg5, arg6, arg7, arg8, arg9, v0, arg10, arg11));
    }

    public(friend) entry fun navi_supply<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        let v0 = spend<T0>(arg0, arg2, arg3, arg9, arg10);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi::supply<T0>(&mut arg0.control, arg4, arg5, arg6, arg7, arg8, v0, arg9, arg10);
    }

    public(friend) entry fun navi_withdraw<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_agent(&arg0.control, arg10, arg11);
        keep<T0>(arg0, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::navi::withdraw<T0>(&mut arg0.control, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun pass_of(arg0: &Config, arg1: address) : 0x2::object::ID {
        let v0 = AgentKey{pos0: arg1};
        0x2::object::id_from_address(0x2::derived_object::derive_address<AgentKey>(0x2::object::id<Config>(arg0), v0))
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun receipt_name(arg0: &Receipt) : 0x1::ascii::String {
        arg0.name
    }

    public fun receipt_pass(arg0: &Receipt) : 0x2::object::ID {
        arg0.pass
    }

    public(friend) entry fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = Paused{paused: arg2};
        0x2::event::emit<Paused>(v0);
    }

    public fun share(arg0: AgentPass) {
        0x2::transfer::share_object<AgentPass>(arg0);
    }

    fun spend<T0>(arg0: &mut AgentPass, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_agent(&arg0.control, arg3, arg4);
        assert!(matches(arg0, 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg1)), 1);
        let v0 = 0x2::allowance::app_balance_spend<T0, PASS>(arg1, 0x2::allowance::spend_permit<PASS>(0x1::internal::permit<PASS>()), arg2, arg3, arg4);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::daily_cap::charge<T0>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::policies::borrow_mut<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::daily_cap::DailyCap<T0>>(0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::policies_mut(&mut arg0.control)), 0x2::balance::value<T0>(&v0), arg3);
        v0
    }

    public(friend) entry fun stake(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_live(arg1);
        let v0 = spend<0x2::sui::SUI>(arg0, arg2, arg3, arg6, arg7);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::staking::stake(&mut arg0.control, arg4, v0, arg5, arg6, arg7)
    }

    public(friend) entry fun unstake(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::assert_agent(&arg0.control, arg4, arg5);
        keep<0x2::sui::SUI>(arg0, 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::staking::unstake(&mut arg0.control, arg2, arg3, arg5));
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &mut AgentPass, arg1: T0, arg2: &0x2::tx_context::TxContext) : T1 {
        let v0 = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::control::edit_positions(&mut arg0.control, arg2);
        assert!(0x2::bag::contains_with_type<T0, T1>(v0, arg1), 2);
        let v1 = 0x2::bag::remove<T0, T1>(v0, arg1);
        let v2 = ObjectWithdrawn{
            pass        : 0x2::object::uid_to_inner(&arg0.id),
            key         : 0x1::type_name::with_defining_ids<T0>(),
            object      : 0x2::object::id<T1>(&v1),
            object_type : 0x1::type_name::with_defining_ids<T1>(),
        };
        0x2::event::emit<ObjectWithdrawn>(v2);
        v1
    }

    // decompiled from Move bytecode v7
}

