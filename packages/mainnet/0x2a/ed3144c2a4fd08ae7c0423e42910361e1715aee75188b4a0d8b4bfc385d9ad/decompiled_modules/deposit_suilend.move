module 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::deposit_suilend {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        vt_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        vt_amount: u64,
        total_deposited: u64,
        total_vt_supply: u64,
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg3: &0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::version::assert_current_version(arg3);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 41);
        let v1 = 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::deposited<T0, T1, T2>(arg0, arg2);
        let v2 = 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::utils::safe_mul_div(v0, 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::total_vt_supply<T0, T1, T2>(arg0), v1);
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::deposit<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        let v3 = DepositEvent{
            vault_id        : 0x2::object::id<0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::Vault<T0, T1, T2>>(arg0),
            deposit_type    : 0x1::type_name::get<T0>(),
            vt_type         : 0x1::type_name::get<T1>(),
            deposit_amount  : v0,
            vt_amount       : v2,
            total_deposited : v1,
            total_vt_supply : 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::event::emit<DepositEvent>(v3);
        0x2::coin::into_balance<T1>(0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::suilend_vault::mint_vt<T0, T1, T2>(arg0, v2, arg5))
    }

    // decompiled from Move bytecode v6
}

