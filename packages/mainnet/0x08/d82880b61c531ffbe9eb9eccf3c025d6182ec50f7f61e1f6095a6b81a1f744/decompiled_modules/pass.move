module 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::pass {
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
        control: 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control,
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

    public fun issue<T0>(arg0: &AgentPass, arg1: &Config, arg2: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_owner(&arg0.control, arg3);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg2);
        assert!(matches(arg0, v0), 0);
        let v1 = 0x2::allowance::expiration_timestamp_ms(v0);
        assert!(0x1::option::is_some<u64>(&v1) && *0x1::option::borrow<u64>(&v1) <= 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::agent_expires_ms(&arg0.control), 0);
        let v2 = Issued{
            pass         : 0x2::object::uid_to_inner(&arg0.id),
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            lifetime_cap : 0x2::allowance::lifetime_cap(v0),
            expires_ms   : v1,
        };
        0x2::event::emit<Issued>(v2);
        0x2::allowance::issue<0x2::balance::Balance<T0>, PASS>(arg2, 0x2::allowance::settings_permit<PASS>(0x1::internal::permit<PASS>()), arg3);
    }

    public fun transfer<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: 0x1::ascii::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::transfer_policy::execute<T0>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::borrow_mut<0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::transfer_policy::TransferPolicy<T0>>(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies_mut(&mut arg0.control)), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::controller(&arg0.control), spend<T0>(arg0, arg2, arg3, arg5, arg6), arg4, arg5);
    }

    public fun control(arg0: &AgentPass) : &0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::Control {
        &arg0.control
    }

    public fun add_policy<T0: store>(arg0: &mut AgentPass, arg1: &Config, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::add_policy<T0>(&mut arg0.control, arg2, arg3);
    }

    public fun destroy(arg0: AgentPass, arg1: &0x2::tx_context::TxContext) {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_owner(&arg0.control, arg1);
        assert!(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::length(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::policies(&arg0.control)) == 0 && 0x2::bag::is_empty(0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::positions(&arg0.control)), 4);
        let v0 = Destroyed{pass: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<Destroyed>(v0);
        let AgentPass {
            id      : v1,
            control : v2,
        } = arg0;
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::destroy(v2);
        0x2::object::delete(v1);
    }

    public fun policies_mut(arg0: &mut AgentPass, arg1: &Config, arg2: &0x2::tx_context::TxContext) : &mut 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::policies::Policies {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::edit_policies(&mut arg0.control, arg2)
    }

    public fun remove_policy<T0: store>(arg0: &mut AgentPass, arg1: &0x2::tx_context::TxContext) : T0 {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::remove_policy<T0>(&mut arg0.control, arg1)
    }

    public fun revoke_agent(arg0: &mut AgentPass, arg1: &0x2::tx_context::TxContext) {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::revoke_agent(&mut arg0.control, arg1);
    }

    public fun set_agent(arg0: &mut AgentPass, arg1: &Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::set_agent(&mut arg0.control, arg2, arg3, arg4, arg5);
    }

    fun assert_live(arg0: &Config) {
        assert!(arg0.version == 2, 5);
        assert!(!arg0.paused, 6);
    }

    public fun burn_receipt(arg0: Receipt) {
        let Receipt {
            id   : v0,
            pass : _,
            name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun cetus_a_to_b<T0, T1>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        let (v0, v1) = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::cetus::a_to_b<T0, T1>(&mut arg0.control, arg4, arg5, spend<T0>(arg0, arg2, arg3, arg7, arg8), arg6, arg7);
        keep<T0>(arg0, v0);
        keep<T1>(arg0, v1);
    }

    public fun cetus_b_to_a<T0, T1>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        let (v0, v1) = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::cetus::b_to_a<T0, T1>(&mut arg0.control, arg4, arg5, spend<T1>(arg0, arg2, arg3, arg7, arg8), arg6, arg7);
        keep<T0>(arg0, v0);
        keep<T1>(arg0, v1);
    }

    public fun create(arg0: &Config, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AgentPass {
        assert_live(arg0);
        let v0 = 0x2::object::new(arg5);
        let v1 = Receipt{
            id   : 0x2::object::new(arg5),
            pass : 0x2::object::uid_to_inner(&v0),
            name : arg1,
        };
        let v2 = Created{
            pass             : 0x2::object::uid_to_inner(&v0),
            receipt          : 0x2::object::id<Receipt>(&v1),
            name             : arg1,
            owner            : 0x2::tx_context::sender(arg5),
            agent            : arg2,
            agent_expires_ms : arg3,
        };
        0x2::event::emit<Created>(v2);
        0x2::transfer::transfer<Receipt>(v1, 0x2::tx_context::sender(arg5));
        AgentPass{
            id      : v0,
            control : 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::new(0x2::object::uid_to_inner(&v0), arg1, arg2, arg3, arg4, arg5),
        }
    }

    public fun deepbook_base_to_quote<T0, T1>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        let (v0, v1) = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::deepbook::base_to_quote<T0, T1>(&mut arg0.control, arg4, spend<T0>(arg0, arg2, arg3, arg6, arg7), arg5, arg6, arg7);
        keep<T0>(arg0, v0);
        keep<T1>(arg0, v1);
    }

    public fun deepbook_quote_to_base<T0, T1>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T1>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T1>>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        let (v0, v1) = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::deepbook::quote_to_base<T0, T1>(&mut arg0.control, arg4, spend<T1>(arg0, arg2, arg3, arg6, arg7), arg5, arg6, arg7);
        keep<T0>(arg0, v0);
        keep<T1>(arg0, v1);
    }

    public fun deposit_object<T0: copy + drop + store, T1: store + key>(arg0: &mut AgentPass, arg1: &Config, arg2: T0, arg3: T1, arg4: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        let v0 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::edit_positions(&mut arg0.control, arg4);
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

    fun init(arg0: PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg1),
            version : 2,
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
            0x2::balance::send_funds<T0>(arg1, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::owner(&arg0.control));
        };
    }

    fun matches(arg0: &AgentPass, arg1: &0x2::allowance::Settings) : bool {
        if (0x2::allowance::funder(arg1) == 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::owner(&arg0.control)) {
            let v1 = 0x2::allowance::spender(arg1);
            let v2 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::agent(&arg0.control);
            0x1::option::contains<address>(&v1, &v2)
        } else {
            false
        }
    }

    public fun migrate(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.version < 2, 5);
        arg0.version = 2;
        let v0 = Migrated{version: 2};
        0x2::event::emit<Migrated>(v0);
    }

    public fun navi_borrow<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 7
    }

    public fun navi_borrow_v2<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_agent(&arg0.control, arg10, arg11);
        keep<T0>(arg0, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::navi::borrow<T0>(&mut arg0.control, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun navi_open(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_owner(&arg0.control, arg2);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::navi::open(&mut arg0.control, arg2);
    }

    public fun navi_repay<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        keep<T0>(arg0, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::navi::repay<T0>(&mut arg0.control, arg4, arg5, arg6, arg7, arg8, arg9, spend<T0>(arg0, arg2, arg3, arg10, arg11), arg10, arg11));
    }

    public fun navi_supply<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::navi::supply<T0>(&mut arg0.control, arg4, arg5, arg6, arg7, arg8, spend<T0>(arg0, arg2, arg3, arg9, arg10), arg9, arg10);
    }

    public fun navi_withdraw<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 7
    }

    public fun navi_withdraw_v2<T0>(arg0: &mut AgentPass, arg1: &Config, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_agent(&arg0.control, arg10, arg11);
        keep<T0>(arg0, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::navi::withdraw<T0>(&mut arg0.control, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
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

    public fun rotate_allowance<T0>(arg0: &AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: &0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_owner(&arg0.control, arg3);
        assert!(0x2::allowance::funder(0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg2)) == 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::owner(&arg0.control), 1);
        0x2::allowance::rotate_spender<0x2::balance::Balance<T0>, PASS>(arg2, 0x2::allowance::settings_permit<PASS>(0x1::internal::permit<PASS>()), 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::agent(&arg0.control));
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = Paused{paused: arg2};
        0x2::event::emit<Paused>(v0);
    }

    public fun share(arg0: AgentPass) {
        0x2::transfer::share_object<AgentPass>(arg0);
    }

    fun spend<T0>(arg0: &AgentPass, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_agent(&arg0.control, arg3, arg4);
        assert!(matches(arg0, 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg1)), 1);
        0x2::allowance::app_balance_spend<T0, PASS>(arg1, 0x2::allowance::spend_permit<PASS>(0x1::internal::permit<PASS>()), arg2, arg3, arg4)
    }

    public fun stake(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<0x2::sui::SUI>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<0x2::sui::SUI>>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::staking::stake(&mut arg0.control, arg4, spend<0x2::sui::SUI>(arg0, arg2, arg3, arg6, arg7), arg5, arg6, arg7)
    }

    public fun unstake(arg0: &mut AgentPass, arg1: &Config, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_live(arg1);
        0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::assert_agent(&arg0.control, arg4, arg5);
        keep<0x2::sui::SUI>(arg0, 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::staking::unstake(&mut arg0.control, arg2, arg3, arg5));
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_object<T0: copy + drop + store, T1: store + key>(arg0: &mut AgentPass, arg1: T0, arg2: &0x2::tx_context::TxContext) : T1 {
        let v0 = 0x4c9010b0be6022e8a4bd91219d5174edc36d524b42d4790784035f424e01f403::control::edit_positions(&mut arg0.control, arg2);
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

