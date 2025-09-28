module 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::base_distributor {
    struct BaseDistributor<phantom T0, phantom T1, phantom T2> has store {
        signer_pubkey: vector<u8>,
        vault: 0x2::balance::Balance<T1>,
        collected_fee: 0x2::balance::Balance<T2>,
        active: bool,
        default_fee_mode: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode,
        configurators: 0x2::table::Table<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>,
        fee_modes: 0x2::table::Table<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>,
        claimed: 0x2::table::Table<ClaimedTableKey, u64>,
    }

    struct ClaimedTableKey has copy, drop, store {
        batch_id: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32,
        user: address,
    }

    struct AirdropClaimed has copy, drop {
        account: address,
        batch_id: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32,
        amount: u64,
    }

    struct ConfiguratorSet has copy, drop {
        batch_id: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32,
        configurator: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32,
    }

    struct FeeModeSet has copy, drop {
        batch_id: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32,
        fee_mode: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode,
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

    public(friend) fun claim_check<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::object::UID, arg3: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg4: &vector<u8>, arg5: u64, arg6: u64, arg7: address, arg8: &vector<u8>) : (0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x2::balance::Balance<T1>) {
        assert!(arg0.active, 13906835308215009285);
        let v0 = ClaimedTableKey{
            batch_id : arg3,
            user     : arg7,
        };
        let v1 = if (0x2::table::contains<ClaimedTableKey, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow<ClaimedTableKey, u64>(&arg0.claimed, v0)
        } else {
            0x2::table::add<ClaimedTableKey, u64>(&mut arg0.claimed, v0, 0);
            0
        };
        let v2 = if (v1 == 0) {
            required_fee<T0, T1, T2>(arg0, arg3, arg5)
        } else {
            0
        };
        assert!(0x2::coin::value<T2>(&arg1) == v2, 13906835376935010317);
        0x2::balance::join<T2>(&mut arg0.collected_fee, 0x2::coin::into_balance<T2>(arg1));
        assert!(arg6 <= arg5, 13906835389819781131);
        assert!(arg6 > v1, 13906835394114093057);
        *0x2::table::borrow_mut<ClaimedTableKey, u64>(&mut arg0.claimed, v0) = arg6;
        signature_check(arg5, arg6, arg7, arg4, &arg3, &arg0.signer_pubkey, arg2, arg8);
        let v3 = arg6 - v1;
        let v4 = AirdropClaimed{
            account  : arg7,
            batch_id : arg3,
            amount   : v3,
        };
        0x2::event::emit<AirdropClaimed>(v4);
        (configurator_of<T0, T1, T2>(arg0, arg3), 0x2::balance::split<T1>(&mut arg0.vault, v3))
    }

    public(friend) fun claim_check_with_merkle_proof<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::object::UID, arg3: &vector<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>, arg4: &vector<u8>, arg5: u64, arg6: u64, arg7: address, arg8: &vector<u8>) : (0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x2::balance::Balance<T1>) {
        let v0 = root_check<T0, T1, T2>(arg0, arg3, arg5, arg7);
        claim_check<T0, T1, T2>(arg0, arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8)
    }

    public fun claimed_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg2: address) : u64 {
        let v0 = ClaimedTableKey{
            batch_id : arg1,
            user     : arg2,
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

    public fun configurator_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32) : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32 {
        *0x2::table::borrow<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(&arg0.configurators, arg1)
    }

    public fun default_fee_mode<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode {
        arg0.default_fee_mode
    }

    public fun deposit_airdrop_token<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = AirdropTokenDeposited{amount: 0x2::coin::value<T1>(&arg1)};
        0x2::event::emit<AirdropTokenDeposited>(v0);
        0x2::balance::join<T1>(&mut arg0.vault, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun fee_mode_of<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32) : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode {
        if (0x2::table::contains<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(&arg0.fee_modes, arg1)) {
            *0x2::table::borrow<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(&arg0.fee_modes, arg1)
        } else {
            arg0.default_fee_mode
        }
    }

    public(friend) fun new_base_distributor<T0, T1, T2>(arg0: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : BaseDistributor<T0, T1, T2> {
        if (0x1::vector::length<u8>(&arg1) == 33) {
            let v0 = &arg1;
            let v1 = 0;
            let v2;
            while (v1 < 0x1::vector::length<u8>(v0)) {
                if (!(*0x1::vector::borrow<u8>(v0, v1) == 0)) {
                    v2 = false;
                    /* label 7 */
                    /* label 8 */
                    assert!(!v2, 13906834612430438407);
                    return BaseDistributor<T0, T1, T2>{
                        signer_pubkey    : arg1,
                        vault            : 0x2::coin::into_balance<T1>(arg2),
                        collected_fee    : 0x2::balance::zero<T2>(),
                        active           : false,
                        default_fee_mode : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::fixed(18446744073709551615),
                        configurators    : 0x2::table::new<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(arg3),
                        fee_modes        : 0x2::table::new<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(arg3),
                        claimed          : 0x2::table::new<ClaimedTableKey, u64>(arg3),
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

    fun recover(arg0: &vector<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>, arg1: vector<u8>) : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(arg0)) {
            let v1 = 0x1::vector::borrow<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(arg0, v0);
            let v2 = 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::from_vec(arg1);
            if (0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::to_u256(&v2) > 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::to_u256(v1)) {
                let v3 = 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::to_vec(v1);
                0x1::vector::append<u8>(&mut v3, arg1);
                arg1 = 0x2::hash::keccak256(&v3);
            } else {
                0x1::vector::append<u8>(&mut arg1, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::to_vec(v1));
                let v4 = &arg1;
                arg1 = 0x2::hash::keccak256(v4);
            };
            v0 = v0 + 1;
        };
        0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::from_vec(arg1)
    }

    public fun required_fee<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg2: u64) : u64 {
        0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::required_fee(fee_mode_of<T0, T1, T2>(arg0, arg1), arg2)
    }

    fun root_check<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>, arg1: &vector<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>, arg2: u64, arg3: address) : 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32 {
        let v0 = 0x2::address::to_bytes(arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        let v1 = recover(arg1, 0x2::hash::keccak256(&v0));
        assert!(0x2::table::contains<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(&arg0.configurators, v1), 13906835673287491593);
        v1
    }

    public fun set_configurator<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg2: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg3: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32) {
        if (0x2::table::contains<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(&arg0.configurators, arg2)) {
            *0x2::table::borrow_mut<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(&mut arg0.configurators, arg2) = arg3;
        } else {
            0x2::table::add<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(&mut arg0.configurators, arg2, arg3);
        };
        let v0 = ConfiguratorSet{
            batch_id     : arg2,
            configurator : arg3,
        };
        0x2::event::emit<ConfiguratorSet>(v0);
    }

    public fun set_default_fee_mode<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg2: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode) {
        arg0.default_fee_mode = arg2;
    }

    public fun set_fee_mode<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg2: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg3: 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode) {
        if (0x2::table::contains<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(&arg0.fee_modes, arg2)) {
            *0x2::table::borrow_mut<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(&mut arg0.fee_modes, arg2) = arg3;
        } else {
            0x2::table::add<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, 0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::fee_mode::FeeMode>(&mut arg0.fee_modes, arg2, arg3);
        };
        let v0 = FeeModeSet{
            batch_id : arg2,
            fee_mode : arg3,
        };
        0x2::event::emit<FeeModeSet>(v0);
    }

    public fun set_signer_pubkey<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg2: vector<u8>) {
        if (0x1::vector::length<u8>(&arg2) == 33) {
            let v0 = &arg2;
            let v1 = 0;
            let v2;
            while (v1 < 0x1::vector::length<u8>(v0)) {
                if (!(*0x1::vector::borrow<u8>(v0, v1) == 0)) {
                    v2 = false;
                    /* label 7 */
                    /* label 8 */
                    assert!(!v2, 13906834694034817031);
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

    fun signature_check(arg0: u64, arg1: u64, arg2: address, arg3: &vector<u8>, arg4: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32, arg5: &vector<u8>, arg6: &0x2::object::UID, arg7: &vector<u8>) {
        let v0 = 0x2::address::to_bytes(arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::bytes32::Bytes32>(arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::UID>(arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(arg7));
        let v1 = x"030000";
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<vector<u8>>(&v0));
        let v2 = 0x2::hash::blake2b256(&v1);
        assert!(0x2::ecdsa_k1::secp256k1_verify(arg3, arg5, &v2, 1), 13906835815021019139);
    }

    public fun signer_pubkey<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : vector<u8> {
        arg0.signer_pubkey
    }

    public fun toggle_active<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>) {
        arg0.active = !arg0.active;
    }

    public fun vault_balance<T0, T1, T2>(arg0: &BaseDistributor<T0, T1, T2>) : u64 {
        0x2::balance::value<T1>(&arg0.vault)
    }

    public fun withdraw_airdrop_token<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::ProjectAdminCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = AirdropTokenWithdrawn{amount: arg2};
        0x2::event::emit<AirdropTokenWithdrawn>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.vault, arg2), arg3)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &mut BaseDistributor<T0, T1, T2>, arg1: &0x39eac4c12b31ef31914f2119b738452b7e316fa19af047a6b07b4c17966177fe::roles::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::balance::value<T2>(&arg0.collected_fee);
        let v1 = FeeWithdrawn{amount: v0};
        0x2::event::emit<FeeWithdrawn>(v1);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.collected_fee, v0), arg2)
    }

    // decompiled from Move bytecode v6
}

