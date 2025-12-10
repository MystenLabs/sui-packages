module 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor {
    struct ConfigurationIdSet has copy, drop {
        configuration_id: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32,
        allocation_strategy: AllocationStrategy,
    }

    struct ConfigurationIdUnset has copy, drop {
        configuration_id: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32,
    }

    struct Distributor<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        allocation_strategies: 0x2::table::Table<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>,
        base_distributor: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::BaseDistributor<T0, T1, T2>,
    }

    struct AllocationStrategy has copy, drop, store {
        strategies: vector<Strategy>,
        default_hook: 0x1::type_name::TypeName,
    }

    struct Strategy has copy, drop, store {
        hook: 0x1::type_name::TypeName,
        max_proportion: u64,
    }

    struct HookCallInfo has copy, drop, store {
        max_allocation: u64,
        calldata: vector<u8>,
    }

    struct ClaimedBalance<phantom T0> {
        configuration_id: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32,
        hook_call_infos: 0x2::vec_map::VecMap<0x1::type_name::TypeName, HookCallInfo>,
        default_hook: 0x1::type_name::TypeName,
        remaining_balance: 0x2::balance::Balance<T0>,
        handler: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32,
        on_behalf_of: address,
    }

    public fun active<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : bool {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::active<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun claimed_of<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>, arg1: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) : u64 {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::claimed_of<T0, T1, T2>(&arg0.base_distributor, arg1, arg2)
    }

    public fun collected_fee_amount<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : u64 {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::collected_fee_amount<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun configuration_id_of<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>, arg1: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) : 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32 {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::configuration_id_of<T0, T1, T2>(&arg0.base_distributor, arg1)
    }

    public fun default_fee_mode<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::fee_mode::FeeMode {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::default_fee_mode<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun deposit_airdrop_token<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::deposit_airdrop_token<T0, T1, T2>(&mut arg0.base_distributor, arg1);
    }

    public fun fee_mode_of<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>, arg1: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) : 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::fee_mode::FeeMode {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::fee_mode_of<T0, T1, T2>(&arg0.base_distributor, arg1)
    }

    public fun required_fee<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>, arg1: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg2: u64) : u64 {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::required_fee<T0, T1, T2>(&arg0.base_distributor, arg1, arg2)
    }

    public fun set_active<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: bool) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_active<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun set_configuration_id<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg3: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_configuration_id<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3);
    }

    public fun set_default_fee_mode<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::fee_mode::FeeMode) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_default_fee_mode<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun set_end_time_ms<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: u64) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_end_time_ms<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun set_fee_mode<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg3: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::fee_mode::FeeMode) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_fee_mode<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3);
    }

    public fun set_signer_pubkey<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: vector<u8>) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_signer_pubkey<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun set_start_time_ms<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: u64) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::set_start_time_ms<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun signer_pubkey<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : vector<u8> {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::signer_pubkey<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun start_end_time_ms<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : (u64, u64) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::start_end_time_ms<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun unset_configuration_id<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::unset_configuration_id<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2);
    }

    public fun vault_balance<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>) : u64 {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::vault_balance<T0, T1, T2>(&arg0.base_distributor)
    }

    public fun withdraw_airdrop_token<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::AirdropTokenWithdrawCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::withdraw_airdrop_token<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, arg3)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::withdraw_fee<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2)
    }

    public fun allocation_strategy_of<T0, T1, T2>(arg0: &Distributor<T0, T1, T2>, arg1: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) : AllocationStrategy {
        *0x2::table::borrow<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&arg0.allocation_strategies, arg1)
    }

    public fun calldata(arg0: &HookCallInfo) : vector<u8> {
        arg0.calldata
    }

    public fun claim<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: vector<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg8: address, arg9: vector<u8>) : ClaimedBalance<T1> {
        let (v0, v1) = 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::claim_check<T0, T1, T2>(&mut arg0.base_distributor, arg1, arg2, &arg0.id, &arg3, &arg4, arg5, arg6, arg7, arg8, &arg9);
        let v2 = v1;
        assert!(0x2::table::contains<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&arg0.allocation_strategies, v0), 13906834694034685957);
        let AllocationStrategy {
            strategies   : v3,
            default_hook : v4,
        } = *0x2::table::borrow<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&arg0.allocation_strategies, v0);
        let v5 = v3;
        let v6 = 0x2::bcs::new(arg9);
        let v7 = &mut v6;
        let v8 = vector[];
        let v9 = 0;
        while (v9 < 0x2::bcs::peel_vec_length(v7)) {
            0x1::vector::push_back<vector<u8>>(&mut v8, 0x2::bcs::peel_vec_u8(v7));
            v9 = v9 + 1;
        };
        assert!(0x1::vector::length<vector<u8>>(&v8) == 0x1::vector::length<Strategy>(&v5) + 1, 13906834724099850251);
        let v10 = 0x2::vec_map::empty<0x1::type_name::TypeName, HookCallInfo>();
        0x1::vector::reverse<vector<u8>>(&mut v8);
        assert!(0x1::vector::length<Strategy>(&v5) == 0x1::vector::length<vector<u8>>(&v8), 13906834749868998655);
        0x1::vector::reverse<Strategy>(&mut v5);
        let v11 = 0;
        while (v11 < 0x1::vector::length<Strategy>(&v5)) {
            let v12 = 0x1::vector::pop_back<Strategy>(&mut v5);
            let v13 = HookCallInfo{
                max_allocation : (((0x2::balance::value<T1>(&v2) as u256) * (v12.max_proportion as u256) / (1000000000 as u256)) as u64),
                calldata       : 0x1::vector::pop_back<vector<u8>>(&mut v8),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, HookCallInfo>(&mut v10, v12.hook, v13);
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<Strategy>(v5);
        0x1::vector::destroy_empty<vector<u8>>(v8);
        let v14 = HookCallInfo{
            max_allocation : 0x2::balance::value<T1>(&v2),
            calldata       : 0x1::vector::pop_back<vector<u8>>(&mut v8),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, HookCallInfo>(&mut v10, v4, v14);
        ClaimedBalance<T1>{
            configuration_id  : v0,
            hook_call_infos   : v10,
            default_hook      : v4,
            remaining_balance : v2,
            handler           : arg7,
            on_behalf_of      : arg8,
        }
    }

    public fun default_hook(arg0: &AllocationStrategy) : 0x1::type_name::TypeName {
        arg0.default_hook
    }

    public fun destroy_empty_claimed_balance<T0>(arg0: ClaimedBalance<T0>) {
        let ClaimedBalance {
            configuration_id  : _,
            hook_call_infos   : v1,
            default_hook      : _,
            remaining_balance : v3,
            handler           : _,
            on_behalf_of      : _,
        } = arg0;
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, HookCallInfo>(v1);
        0x2::balance::destroy_zero<T0>(v3);
    }

    public fun extract_claimed_balance<T0, T1: drop>(arg0: &mut ClaimedBalance<T0>, arg1: T1, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, HookCallInfo>(&arg0.hook_call_infos, &v0), 13906834904488214535);
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, HookCallInfo>(&mut arg0.hook_call_infos, &v0);
        let HookCallInfo {
            max_allocation : v3,
            calldata       : _,
        } = v2;
        if (0x2::vec_map::length<0x1::type_name::TypeName, HookCallInfo>(&arg0.hook_call_infos) == 0) {
            assert!(v0 == arg0.default_hook, 13906834930258018311);
            0x2::balance::withdraw_all<T0>(&mut arg0.remaining_balance)
        } else {
            assert!(v0 != arg0.default_hook, 13906834943142920199);
            assert!(arg2 <= v3 && arg2 <= 0x2::balance::value<T0>(&arg0.remaining_balance), 13906834956027953161);
            0x2::balance::split<T0>(&mut arg0.remaining_balance, arg2)
        }
    }

    public fun handler<T0>(arg0: &ClaimedBalance<T0>) : 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32 {
        arg0.handler
    }

    public fun hook(arg0: &Strategy) : 0x1::type_name::TypeName {
        arg0.hook
    }

    public fun hook_call_info<T0, T1: drop>(arg0: &ClaimedBalance<T0>) : HookCallInfo {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        *0x2::vec_map::get<0x1::type_name::TypeName, HookCallInfo>(&arg0.hook_call_infos, &v0)
    }

    public fun max_allocation(arg0: &HookCallInfo) : u64 {
        arg0.max_allocation
    }

    public fun max_proportion(arg0: &Strategy) : u64 {
        arg0.max_proportion
    }

    public fun new_distributor<T0, T1, T2>(arg0: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg1: bool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : Distributor<T0, T1, T2> {
        Distributor<T0, T1, T2>{
            id                    : 0x2::object::new(arg3),
            allocation_strategies : 0x2::table::new<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(arg3),
            base_distributor      : 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::base_distributor::new_base_distributor<T0, T1, T2>(arg0, arg1, arg2, arg3),
        }
    }

    public fun new_strategy<T0>(arg0: u64) : Strategy {
        Strategy{
            hook           : 0x1::type_name::with_defining_ids<T0>(),
            max_proportion : arg0,
        }
    }

    public fun on_behalf_of<T0>(arg0: &ClaimedBalance<T0>) : address {
        arg0.on_behalf_of
    }

    public fun receive_airdrop_token<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg0.id, arg1);
        deposit_airdrop_token<T0, T1, T2>(arg0, v0);
    }

    public fun set_allocation_strategy<T0, T1, T2, T3>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, arg3: vector<Strategy>) {
        let v0 = &arg3;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Strategy>(v0)) {
            if (!(0x1::vector::borrow<Strategy>(v0, v1).max_proportion <= 1000000000)) {
                v2 = false;
                /* label 6 */
                assert!(v2, 13906835269560041473);
                let v3 = 0x1::type_name::with_defining_ids<T3>();
                let v4 = &arg3;
                let v5 = 0;
                let v6;
                while (v5 < 0x1::vector::length<Strategy>(v4)) {
                    if (0x1::vector::borrow<Strategy>(v4, v5).hook == v3) {
                        v6 = true;
                        /* label 15 */
                        assert!(!v6, 13906835286740041731);
                        let v7 = AllocationStrategy{
                            strategies   : arg3,
                            default_hook : v3,
                        };
                        if (0x2::table::contains<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&arg0.allocation_strategies, arg2)) {
                            *0x2::table::borrow_mut<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&mut arg0.allocation_strategies, arg2) = v7;
                        } else {
                            0x2::table::add<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&mut arg0.allocation_strategies, arg2, v7);
                        };
                        let v8 = ConfigurationIdSet{
                            configuration_id    : arg2,
                            allocation_strategy : v7,
                        };
                        0x2::event::emit<ConfigurationIdSet>(v8);
                        return
                    };
                    v5 = v5 + 1;
                };
                v6 = false;
                /* goto 15 */
            } else {
                v1 = v1 + 1;
            };
        };
        v2 = true;
        /* goto 6 */
    }

    public fun strategies(arg0: &AllocationStrategy) : vector<Strategy> {
        arg0.strategies
    }

    public fun unset_allocation_strategy<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::ProjectAdminCap<T0>, arg2: 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32) {
        0x2::table::remove<0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::bytes32::Bytes32, AllocationStrategy>(&mut arg0.allocation_strategies, arg2);
        let v0 = ConfigurationIdUnset{configuration_id: arg2};
        0x2::event::emit<ConfigurationIdUnset>(v0);
    }

    entry fun withdraw_airdrop_token_to_sender<T0, T1, T2>(arg0: &mut Distributor<T0, T1, T2>, arg1: &0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::roles::AirdropTokenWithdrawCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::min(arg2, vault_balance<T0, T1, T2>(arg0));
        let v1 = withdraw_airdrop_token<T0, T1, T2>(arg0, arg1, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

