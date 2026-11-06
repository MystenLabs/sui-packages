module 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::protocol_fees {
    struct Ledger<phantom T0, phantom T1> has store {
        package_witness: 0x1::type_name::TypeName,
        origin: 0x2::object::ID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun pay<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.partner_id), 7);
        pay_treasury<T0, T1>(arg0, arg1, 0, 0, 0, arg2);
    }

    public fun accrue<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.meme, arg1);
        0x2::balance::join<T1>(&mut arg0.quote, arg2);
    }

    public fun accrue_sui<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public fun balances<T0, T1>(arg0: &Ledger<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui))
    }

    public fun destroy<T0, T1>(arg0: Ledger<T0, T1>) {
        let (v0, v1, v2) = balances<T0, T1>(&arg0);
        let v3 = if (v0 == 0) {
            if (v1 == 0) {
                v2 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13);
        let Ledger {
            package_witness : _,
            origin          : _,
            partner_id      : _,
            meme            : v7,
            quote           : v8,
            sui             : v9,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v7);
        0x2::balance::destroy_zero<T1>(v8);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
    }

    public fun new<T0, T1, T2: drop>(arg0: T2, arg1: &0x2::object::UID, arg2: 0x1::option::Option<0x2::object::ID>) : Ledger<T0, T1> {
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 6);
        Ledger<T0, T1>{
            package_witness : 0x1::type_name::with_original_ids<T2>(),
            origin          : 0x2::object::uid_to_inner(arg1),
            partner_id      : arg2,
            meme            : 0x2::balance::zero<T0>(),
            quote           : 0x2::balance::zero<T1>(),
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun origin<T0, T1>(arg0: &Ledger<T0, T1>) : 0x2::object::ID {
        arg0.origin
    }

    public fun package_witness<T0, T1>(arg0: &Ledger<T0, T1>) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun partner_id<T0, T1>(arg0: &Ledger<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.partner_id
    }

    fun pay_treasury<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::Treasury, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::destination(arg1);
        let (v1, v2, v3) = balances<T0, T1>(arg0);
        let v4 = if (v1 + arg2 == 0) {
            if (v2 + arg3 == 0) {
                v3 + arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            return
        };
        0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::payout::pay<T0>(&mut arg0.meme, v1, v0, arg5);
        0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::payout::pay<T1>(&mut arg0.quote, v2, v0, arg5);
        0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::payout::pay<0x2::sui::SUI>(&mut arg0.sui, v3, v0, arg5);
        0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_core_events::protocol_fees_paid<T0, T1>(arg0.package_witness, arg0.origin, v0, v1, v2, v3, arg0.partner_id, arg2, arg3, arg4);
    }

    public fun pay_with_partner<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::blast_treasury::Treasury, arg2: &0xd28c38a1c669d7914e616f22bb09c79d6a65587277c6799554fed025edbb109b::blast_partners::Partner, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xd28c38a1c669d7914e616f22bb09c79d6a65587277c6799554fed025edbb109b::blast_partners::Partner>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.partner_id, &v0), 7);
        let v1 = 0xd28c38a1c669d7914e616f22bb09c79d6a65587277c6799554fed025edbb109b::blast_partners::pay<T0>(arg2, &mut arg0.meme, arg3);
        let v2 = 0xd28c38a1c669d7914e616f22bb09c79d6a65587277c6799554fed025edbb109b::blast_partners::pay<T1>(arg2, &mut arg0.quote, arg3);
        let v3 = 0xd28c38a1c669d7914e616f22bb09c79d6a65587277c6799554fed025edbb109b::blast_partners::pay<0x2::sui::SUI>(arg2, &mut arg0.sui, arg3);
        pay_treasury<T0, T1>(arg0, arg1, v1, v2, v3, arg3);
    }

    public fun take_cut<T0, T1>(arg0: &mut Ledger<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::bps::Bps, arg4: 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::bps::Bps) : (u64, u64) {
        let v0 = 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::bps::apply_up(arg3, 0x2::balance::value<T0>(arg1));
        let v1 = 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::bps::apply_up(arg4, 0x2::balance::value<T1>(arg2));
        0x2::balance::join<T0>(&mut arg0.meme, 0x2::balance::split<T0>(arg1, v0));
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::balance::split<T1>(arg2, v1));
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

