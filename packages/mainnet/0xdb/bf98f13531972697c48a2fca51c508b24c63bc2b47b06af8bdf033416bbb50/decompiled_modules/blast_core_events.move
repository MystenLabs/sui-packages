module 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_core_events {
    struct ProtocolFeesPaid<phantom T0, phantom T1> has copy, drop {
        package_witness: 0x1::type_name::TypeName,
        origin: 0x2::object::ID,
        treasury: address,
        meme_amount: u64,
        quote_amount: u64,
        sui_amount: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        partner_meme_amount: u64,
        partner_quote_amount: u64,
        partner_sui_amount: u64,
    }

    public(friend) fun protocol_fees_paid<T0, T1>(arg0: 0x1::type_name::TypeName, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = ProtocolFeesPaid<T0, T1>{
            package_witness      : arg0,
            origin               : arg1,
            treasury             : arg2,
            meme_amount          : arg3,
            quote_amount         : arg4,
            sui_amount           : arg5,
            partner_id           : arg6,
            partner_meme_amount  : arg7,
            partner_quote_amount : arg8,
            partner_sui_amount   : arg9,
        };
        0x2::event::emit<ProtocolFeesPaid<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

