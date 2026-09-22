module 0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::events {
    struct NewCustodyVault<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct AssetAdded<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        single_vault_id: 0x2::object::ID,
        decimal: u8,
        mint_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        burn_fee_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        min_burn_amount: u64,
    }

    struct Mint<phantom T0, phantom T1> has copy, drop {
        asset_in_amount: u64,
        asset_balance: u64,
        credit_out_amount: u64,
        asset_credit_backing: u64,
        credit_supply: u64,
        fee_amount: u64,
    }

    struct Burn<phantom T0, phantom T1> has copy, drop {
        credit_in_amount: u64,
        asset_credit_backing: u64,
        asset_out_amount: u64,
        asset_balance: u64,
        credit_supply: u64,
        fee_amount: u64,
    }

    public(friend) fun emit_asset_added<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: u64) {
        let v0 = AssetAdded<T0, T1>{
            vault_id        : arg0,
            single_vault_id : arg1,
            decimal         : arg2,
            mint_fee_rate   : arg3,
            burn_fee_rate   : arg4,
            min_burn_amount : arg5,
        };
        0x2::event::emit<AssetAdded<T0, T1>>(v0);
    }

    public(friend) fun emit_burn<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Burn<T0, T1>{
            credit_in_amount     : arg0,
            asset_credit_backing : arg1,
            asset_out_amount     : arg2,
            asset_balance        : arg3,
            credit_supply        : arg4,
            fee_amount           : arg5,
        };
        0x2::event::emit<Burn<T0, T1>>(v0);
    }

    public(friend) fun emit_mint<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Mint<T0, T1>{
            asset_in_amount      : arg0,
            asset_balance        : arg1,
            credit_out_amount    : arg2,
            asset_credit_backing : arg3,
            credit_supply        : arg4,
            fee_amount           : arg5,
        };
        0x2::event::emit<Mint<T0, T1>>(v0);
    }

    public(friend) fun emit_new_custody_vault<T0>(arg0: 0x2::object::ID) {
        let v0 = NewCustodyVault<T0>{vault_id: arg0};
        0x2::event::emit<NewCustodyVault<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

