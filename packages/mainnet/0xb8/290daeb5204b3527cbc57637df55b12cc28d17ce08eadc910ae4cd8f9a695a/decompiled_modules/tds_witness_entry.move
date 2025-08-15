module 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_witness_entry {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct CreateLendingAccountCap has copy, drop {
        signer: address,
        index: u64,
        lending_index: u64,
        account_cap_id: address,
    }

    struct DepositLending has copy, drop {
        signer: address,
        index: u64,
        lending_index: u64,
        u64_padding: vector<u64>,
    }

    struct WithdrawLending has copy, drop {
        signer: address,
        index: u64,
        lending_index: u64,
        u64_padding: vector<u64>,
    }

    public fun add_lending_account_cap<T0: store + key>(arg0: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg1: u64, arg2: u64, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg0, arg1, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg0);
        let v0 = CreateLendingAccountCap{
            signer         : 0x2::tx_context::sender(arg4),
            index          : arg1,
            lending_index  : arg2,
            account_cap_id : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::add_lending_account_cap_<T0>(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<CreateLendingAccountCap>(v0);
    }

    public fun borrow_lending_account_cap<T0: store + key>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<T0>, 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::LendingCapHotPotato) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg1, arg2, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::borrow_lending_account_cap_<T0>(arg1, arg2, arg3);
        (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<T0>(arg0, v0, lending_witness(arg2, arg3)), v1)
    }

    public fun deposit_from_lending<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64, arg3: u64, arg4: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T0>>, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg1, arg2, arg6);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg1, arg2);
        let v0 = WITNESS{dummy_field: false};
        let v1 = WithdrawLending{
            signer        : 0x2::tx_context::sender(arg6),
            index         : arg2,
            lending_index : arg3,
            u64_padding   : 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::deposit_from_lending_<T0>(arg1, arg2, arg3, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0x2::balance::Balance<T0>, WITNESS>(arg0, arg4, v0), arg5),
        };
        0x2::event::emit<WithdrawLending>(v1);
    }

    fun lending_witness(arg0: u64, arg1: u64) : 0x1::string::String {
        if (arg1 == 5) {
            0x1::string::utf8(b"37853e40e10a44aa9ded5a7bf9c3e2d973830f290dfd03cfbfd76213dd1b8627::dov_alphalend::WITNESS")
        } else {
            0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::invalid_witness(arg0);
            0x1::string::utf8(b"")
        }
    }

    public fun otc<T0: drop, T1, T2>(arg0: T0, arg1: vector<u8>, arg2: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T2>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, 0x1::option::Option<0x2::balance::Balance<T2>>, vector<u64>) {
        safety_check<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::balance::Balance<T2>>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        let v1 = b"";
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &v1, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg8) <= arg7 + 20000, 1);
        let (_, _, _, _, v6, _, _, _, _, _, _, _) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_mut_registry_inner(arg2);
        let (v14, v15, v16) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::witness_otc_<T1, T2>(arg2, arg3, arg4, arg5, arg6, 0x2::balance::split<T2>(&mut arg6, (((0x2::balance::value<T2>(&arg6) as u128) * (0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::get_bid_fee_bp(v6, arg3) as u128) / 10000) as u64)), arg8, arg9);
        let v17 = v16;
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::emit_witness_otc_event(0x1::type_name::get<T0>(), arg2, arg3, *0x1::vector::borrow<u64>(&v17, 0), *0x1::vector::borrow<u64>(&v17, 1), *0x1::vector::borrow<u64>(&v17, 2), *0x1::vector::borrow<u64>(&v17, 3), arg9);
        (v14, v15, v17)
    }

    public fun return_lending_account_cap<T0: store + key>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64, arg3: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<T0>, arg4: 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::LendingCapHotPotato, arg5: &mut 0x2::tx_context::TxContext) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg1, arg2, arg5);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        let v0 = WITNESS{dummy_field: false};
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::return_lending_account_cap_<T0>(arg1, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<T0, WITNESS>(arg0, arg3, v0), arg4);
    }

    fun safety_check<T0: drop, T1, T2>(arg0: T0, arg1: &0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64) {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_witness<T0>(arg1, arg0, arg2);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T1, T2>(arg1, arg2);
    }

    public fun withdraw_for_lending<T0, T1>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T0>> {
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::validate_portfolio_authority(arg1, arg2, arg4);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::version_check(arg1);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::portfolio_vault_token_check<T0, T1>(arg1, arg2);
        let (v0, v1) = 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::withdraw_for_lending_<T0>(arg1, arg2, arg3);
        let v2 = DepositLending{
            signer        : 0x2::tx_context::sender(arg4),
            index         : arg2,
            lending_index : arg3,
            u64_padding   : v1,
        };
        0x2::event::emit<DepositLending>(v2);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0x2::balance::Balance<T0>>(arg0, v0, lending_witness(arg2, arg3))
    }

    // decompiled from Move bytecode v6
}

