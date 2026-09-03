module 0xdacaf624c4802c9ff7b8c72447207f5078b78be246f78e143d63e6cd89b4f63d::sid {
    struct MarkStrike has copy, drop {
        kind: u8,
        value: u128,
        name: 0x1::string::String,
    }

    struct Expiry has copy, drop {
        kind: u8,
        value: u64,
    }

    struct IndexPx has copy, drop {
        asset: 0x1::string::String,
        exchange: 0x1::string::String,
        base_asset: 0x1::string::String,
        quote_asset: 0x1::string::String,
        index_type: 0x1::option::Option<0x1::string::String>,
        index_spread: bool,
        expiry: 0x1::option::Option<Expiry>,
        decimals: u8,
        timestamp_precision: 0x1::string::String,
    }

    struct MarkPx has copy, drop {
        asset: 0x1::string::String,
        exchange: 0x1::string::String,
        base_asset: 0x1::string::String,
        quote_asset: 0x1::string::String,
        expiry: 0x1::option::Option<Expiry>,
        strike: 0x1::option::Option<vector<MarkStrike>>,
        model: 0x1::option::Option<0x1::string::String>,
        moneyness: 0x1::option::Option<vector<u128>>,
        option_type: 0x1::option::Option<0x1::string::String>,
        greeks: 0x1::option::Option<vector<0x1::string::String>>,
        decimals: u8,
        timestamp_precision: 0x1::string::String,
    }

    struct ModelParams has copy, drop {
        asset: 0x1::string::String,
        exchange: 0x1::string::String,
        base_asset: 0x1::string::String,
        model: 0x1::string::String,
        expiry: Expiry,
        decimals: u8,
        timestamp_precision: 0x1::string::String,
    }

    struct SettlementPx has copy, drop {
        exchange: 0x1::string::String,
        base_asset: 0x1::string::String,
        expiry: Expiry,
        asset: 0x1::string::String,
        decimals: u8,
        timestamp_precision: 0x1::string::String,
    }

    fun digest(arg0: address, arg1: vector<u8>, arg2: vector<u8>) : u256 {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::string::utf8(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, arg2);
        keccak_to_u256(v0)
    }

    public fun expiry_at(arg0: u64) : Expiry {
        Expiry{
            kind  : 0,
            value : arg0,
        }
    }

    public fun expiry_tenor(arg0: u64) : Expiry {
        Expiry{
            kind  : 1,
            value : arg0,
        }
    }

    public fun index_px(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<Expiry>, arg4: u8, arg5: 0x1::string::String) : u256 {
        index_px_generic(arg0, arg1, 0x1::string::utf8(b"blockscholes"), arg2, 0x1::string::utf8(b"USD"), 0x1::option::none<0x1::string::String>(), false, arg3, arg4, arg5)
    }

    public fun index_px_generic(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: bool, arg7: 0x1::option::Option<Expiry>, arg8: u8, arg9: 0x1::string::String) : u256 {
        let v0 = IndexPx{
            asset               : arg1,
            exchange            : arg2,
            base_asset          : arg3,
            quote_asset         : arg4,
            index_type          : arg5,
            index_spread        : arg6,
            expiry              : arg7,
            decimals            : arg8,
            timestamp_precision : arg9,
        };
        digest(arg0, b"index.px", 0x2::bcs::to_bytes<IndexPx>(&v0))
    }

    fun keccak_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0x2::hash::keccak256(&arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 32) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(&v0, v2) as u256);
            v2 = v2 + 1;
        };
        v1
    }

    public fun mark_px(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<Expiry>, arg5: u8, arg6: 0x1::string::String) : u256 {
        mark_px_generic(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"USD"), arg4, 0x1::option::none<vector<MarkStrike>>(), 0x1::option::none<0x1::string::String>(), 0x1::option::none<vector<u128>>(), 0x1::option::none<0x1::string::String>(), 0x1::option::none<vector<0x1::string::String>>(), arg5, arg6)
    }

    public fun mark_px_generic(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<Expiry>, arg6: 0x1::option::Option<vector<MarkStrike>>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<vector<u128>>, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::option::Option<vector<0x1::string::String>>, arg11: u8, arg12: 0x1::string::String) : u256 {
        let v0 = MarkPx{
            asset               : arg1,
            exchange            : arg2,
            base_asset          : arg3,
            quote_asset         : arg4,
            expiry              : arg5,
            strike              : arg6,
            model               : arg7,
            moneyness           : arg8,
            option_type         : arg9,
            greeks              : arg10,
            decimals            : arg11,
            timestamp_precision : arg12,
        };
        digest(arg0, b"mark.px", 0x2::bcs::to_bytes<MarkPx>(&v0))
    }

    public fun mark_strike(arg0: u8, arg1: u128, arg2: 0x1::string::String) : MarkStrike {
        if (arg0 == 0) {
            assert!(0x1::string::is_empty(&arg2), 0);
        } else {
            assert!(arg0 == 1, 0);
            assert!(arg1 == 0, 0);
            assert!(arg2 == 0x1::string::utf8(b"atm_spot") || arg2 == 0x1::string::utf8(b"atm_forward"), 0);
        };
        MarkStrike{
            kind  : arg0,
            value : arg1,
            name  : arg2,
        }
    }

    public fun model_params(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: Expiry, arg5: u8, arg6: 0x1::string::String) : u256 {
        model_params_generic(arg0, arg1, 0x1::string::utf8(b"composite"), arg2, arg3, arg4, arg5, arg6)
    }

    public fun model_params_generic(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: Expiry, arg6: u8, arg7: 0x1::string::String) : u256 {
        let v0 = ModelParams{
            asset               : arg1,
            exchange            : arg2,
            base_asset          : arg3,
            model               : arg4,
            expiry              : arg5,
            decimals            : arg6,
            timestamp_precision : arg7,
        };
        digest(arg0, b"model.params", 0x2::bcs::to_bytes<ModelParams>(&v0))
    }

    public fun settlement_px(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: 0x1::string::String) : u256 {
        settlement_px_generic(arg0, 0x1::string::utf8(b"spot"), 0x1::string::utf8(b"composite"), arg1, arg2, arg3, arg4)
    }

    public fun settlement_px_generic(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: 0x1::string::String) : u256 {
        let v0 = SettlementPx{
            exchange            : arg2,
            base_asset          : arg3,
            expiry              : expiry_at(arg4),
            asset               : arg1,
            decimals            : arg5,
            timestamp_precision : arg6,
        };
        digest(arg0, b"settlement.px", 0x2::bcs::to_bytes<SettlementPx>(&v0))
    }

    // decompiled from Move bytecode v7
}

