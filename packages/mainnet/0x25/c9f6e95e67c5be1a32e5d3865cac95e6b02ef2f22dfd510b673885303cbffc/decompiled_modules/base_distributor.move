module 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::base_distributor {
    struct BaseDistributor<phantom T0, phantom T1, phantom T2> has store {
        dynamic_recipient: bool,
        signer_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<T1>,
        collected_fee: 0x2::balance::Balance<T2>,
        active: bool,
        start_time_ms: u64,
        end_time_ms: u64,
        default_fee_mode: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode,
        configuration_ids: 0x2::table::Table<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>,
        fee_modes: 0x2::table::Table<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>,
        claimed: 0x2::table::Table<ClaimedTableKey, u64>,
    }

    struct ClaimedTableKey has copy, drop, store {
        merkle_root: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
        user: address,
    }

    struct AirdropClaimed has copy, drop {
        handler: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
        recipient: address,
        merkle_root: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
        amount: u64,
    }

    struct ConfigurationIdSet has copy, drop {
        merkle_root: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
        configuration_id: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
    }

    struct ConfigurationIdUnset has copy, drop {
        merkle_root: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
    }

    struct FeeModeSet has copy, drop {
        merkle_root: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32,
        fee_mode: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode,
    }

    struct AirdropTokenDeposited has copy, drop {
        amount: u64,
    }

    struct AirdropTokenWithdrawn has copy, drop {
        amount: u64,
    }

    struct FeeWithdrawn has copy, drop {
        amount: u64,
    }

    public fun active<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : bool {
        arg0.active
    }

    public(friend) fun claim_check<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::object::UID, arg4: &vector<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>, arg5: &vector<u8>, arg6: u64, arg7: u64, arg8: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg9: address, arg10: &vector<u8>) : (0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (arg0.active) {
            if (arg0.start_time_ms <= v0) {
                v0 <= arg0.end_time_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906835531553308677);
        let v2 = if (arg0.dynamic_recipient) {
            true
        } else {
            let v3 = 0x2::address::to_bytes(arg9);
            0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::to_address(&arg8) == 0x2::address::from_bytes(0x2::hash::keccak256(&v3))
        };
        assert!(v2, 13906835548733964305);
        let v4 = root_check<T0, T1, T2>(arg0, arg4, arg6, &arg8);
        let v5 = ClaimedTableKey{
            merkle_root : v4,
            user        : arg9,
        };
        let v6 = if (0x2::table::contains<ClaimedTableKey, u64>(&arg0.claimed, v5)) {
            *0x2::table::borrow<ClaimedTableKey, u64>(&arg0.claimed, v5)
        } else {
            0x2::table::add<ClaimedTableKey, u64>(&mut arg0.claimed, v5, 0);
            0
        };
        let v7 = if (v6 == 0) {
            required_fee<T0, T1, T2>(arg0, v4, arg6)
        } else {
            0
        };
        assert!(0x2::coin::value<T2>(&arg2) == v7, 13906835630338080781);
        0x2::balance::join<T2>(&mut arg0.collected_fee, 0x2::coin::into_balance<T2>(arg2));
        assert!(arg7 <= arg6, 13906835643222851595);
        assert!(arg7 > v6, 13906835647517163521);
        *0x2::table::borrow_mut<ClaimedTableKey, u64>(&mut arg0.claimed, v5) = arg7;
        signature_check(arg5, &arg0.signer_pubkey, &arg8, arg9, arg6, arg7, &v4, arg3, arg10);
        let v8 = arg7 - v6;
        let v9 = AirdropClaimed{
            handler     : arg8,
            recipient   : arg9,
            merkle_root : v4,
            amount      : v8,
        };
        0x2::event::emit<AirdropClaimed>(v9);
        (configuration_id_of<T0, T1, T2>(arg0, v4), 0x2::balance::split<T1>(&mut arg0.vault, v8))
    }

    public fun claimed_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg2: address) : u64 {
        let v0 = ClaimedTableKey{
            merkle_root : arg1,
            user        : arg2,
        };
        if (0x2::table::contains<ClaimedTableKey, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow<ClaimedTableKey, u64>(&arg0.claimed, v0)
        } else {
            0
        }
    }

    public fun collected_fee_amount<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : u64 {
        0x2::balance::value<T2>(&arg0.collected_fee)
    }

    public fun configuration_id_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32) : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32 {
        *0x2::table::borrow<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&arg0.configuration_ids, arg1)
    }

    public fun default_fee_mode<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode {
        arg0.default_fee_mode
    }

    public fun deposit_airdrop_token<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = AirdropTokenDeposited{amount: 0x2::coin::value<T1>(&arg1)};
        0x2::event::emit<AirdropTokenDeposited>(v0);
        0x2::balance::join<T1>(&mut arg0.vault, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun fee_mode_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32) : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode {
        if (0x2::table::contains<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(&arg0.fee_modes, arg1)) {
            *0x2::table::borrow<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(&arg0.fee_modes, arg1)
        } else {
            arg0.default_fee_mode
        }
    }

    public(friend) fun new_base_distributor<T0, T1, T2>(arg0: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg1: bool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : BaseDistributor<T0, T1, T2> {
        if (0x1::vector::length<u8>(&arg2) == 33) {
            let v0 = &arg2;
            let v1 = 0;
            let v2;
            while (v1 < 0x1::vector::length<u8>(v0)) {
                if (!(*0x1::vector::borrow<u8>(v0, v1) == 0)) {
                    v2 = false;
                    /* label 7 */
                    /* label 8 */
                    assert!(!v2, 13906834646790176775);
                    return BaseDistributor<T0, T1, T2>{
                        dynamic_recipient : arg1,
                        signer_pubkey     : arg2,
                        vault             : 0x2::balance::zero<T1>(),
                        collected_fee     : 0x2::balance::zero<T2>(),
                        active            : false,
                        start_time_ms     : 0,
                        end_time_ms       : 18446744073709551615,
                        default_fee_mode  : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::fixed(18446744073709551615),
                        configuration_ids : 0x2::table::new<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg3),
                        fee_modes         : 0x2::table::new<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(arg3),
                        claimed           : 0x2::table::new<ClaimedTableKey, u64>(arg3),
                    }
                };
                v1 = v1 + 1;
            };
            v2 = true;
            /* goto 7 */
        } else {
            /* goto 8 */
        };
    }

    fun recover(arg0: &vector<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>, arg1: vector<u8>) : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg0)) {
            let v1 = 0x1::vector::borrow<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg0, v0);
            let v2 = 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::from_vec(arg1);
            if (0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::to_u256(&v2) > 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::to_u256(v1)) {
                let v3 = 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::to_vec(v1);
                0x1::vector::append<u8>(&mut v3, arg1);
                arg1 = 0x2::hash::keccak256(&v3);
            } else {
                0x1::vector::append<u8>(&mut arg1, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::to_vec(v1));
                let v4 = &arg1;
                arg1 = 0x2::hash::keccak256(v4);
            };
            v0 = v0 + 1;
        };
        0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::from_vec(arg1)
    }

    public fun required_fee<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg2: u64) : u64 {
        0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::required_fee(fee_mode_of<T0, T1, T2>(arg0, arg1), arg2)
    }

    fun root_check<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: &vector<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>, arg2: u64, arg3: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32) : 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32 {
        let v0 = 0x1::bcs::to_bytes<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        let v1 = recover(arg1, 0x2::hash::keccak256(&v0));
        assert!(0x2::table::contains<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&arg0.configuration_ids, v1), 13906835849381150729);
        v1
    }

    public fun set_active<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: bool) {
        arg0.active = arg2;
    }

    public fun set_configuration_id<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg3: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32) {
        if (0x2::table::contains<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&arg0.configuration_ids, arg2)) {
            *0x2::table::borrow_mut<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&mut arg0.configuration_ids, arg2) = arg3;
        } else {
            0x2::table::add<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&mut arg0.configuration_ids, arg2, arg3);
        };
        let v0 = ConfigurationIdSet{
            merkle_root      : arg2,
            configuration_id : arg3,
        };
        0x2::event::emit<ConfigurationIdSet>(v0);
    }

    public fun set_default_fee_mode<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode) {
        arg0.default_fee_mode = arg2;
    }

    public fun set_end_time_ms<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: u64) {
        assert!(arg0.start_time_ms <= arg2, 13906834986093117455);
        arg0.end_time_ms = arg2;
    }

    public fun set_fee_mode<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg3: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode) {
        if (0x2::table::contains<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(&arg0.fee_modes, arg2)) {
            *0x2::table::borrow_mut<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(&mut arg0.fee_modes, arg2) = arg3;
        } else {
            0x2::table::add<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::fee_mode::FeeMode>(&mut arg0.fee_modes, arg2, arg3);
        };
        let v0 = FeeModeSet{
            merkle_root : arg2,
            fee_mode    : arg3,
        };
        0x2::event::emit<FeeModeSet>(v0);
    }

    public fun set_signer_pubkey<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: vector<u8>) {
        if (0x1::vector::length<u8>(&arg2) == 33) {
            let v0 = &arg2;
            let v1 = 0;
            let v2;
            while (v1 < 0x1::vector::length<u8>(v0)) {
                if (!(*0x1::vector::borrow<u8>(v0, v1) == 0)) {
                    v2 = false;
                    /* label 7 */
                    /* label 8 */
                    assert!(!v2, 13906834741279457287);
                    arg0.signer_pubkey = arg2;
                    return
                };
                v1 = v1 + 1;
            };
            v2 = true;
            /* goto 7 */
        } else {
            /* goto 8 */
        };
    }

    public fun set_start_time_ms<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: u64) {
        assert!(arg2 <= arg0.end_time_ms, 13906834947438411791);
        arg0.start_time_ms = arg2;
    }

    fun signature_check(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg3: address, arg4: u64, arg5: u64, arg6: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, arg7: &0x2::object::UID, arg8: &vector<u8>) {
        let v0 = 0x1::bcs::to_bytes<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::UID>(arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(arg8));
        let v1 = x"030000";
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<vector<u8>>(&v0));
        let v2 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(arg0, arg1, &v2, 1), 13906835999704612867);
    }

    public fun signer_pubkey<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : vector<u8> {
        arg0.signer_pubkey
    }

    public fun start_end_time_ms<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : (u64, u64) {
        (arg0.start_time_ms, arg0.end_time_ms)
    }

    public fun unset_configuration_id<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::ProjectAdminCap<T0>, arg2: 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32) {
        0x2::table::remove<0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32, 0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::bytes32::Bytes32>(&mut arg0.configuration_ids, arg2);
        let v0 = ConfigurationIdUnset{merkle_root: arg2};
        0x2::event::emit<ConfigurationIdUnset>(v0);
    }

    public fun vault_balance<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.vault)
    }

    public fun withdraw_airdrop_token<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::AirdropTokenWithdrawCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = AirdropTokenWithdrawn{amount: arg2};
        0x2::event::emit<AirdropTokenWithdrawn>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.vault, arg2), arg3)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x25c9f6e95e67c5be1a32e5d3865cac95e6b02ef2f22dfd510b673885303cbffc::roles::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::balance::value<T2>(&arg0.collected_fee);
        let v1 = FeeWithdrawn{amount: v0};
        0x2::event::emit<FeeWithdrawn>(v1);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.collected_fee, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

