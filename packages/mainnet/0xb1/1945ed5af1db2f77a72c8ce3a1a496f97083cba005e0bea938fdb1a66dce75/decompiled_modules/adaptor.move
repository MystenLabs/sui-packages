module 0xb11945ed5af1db2f77a72c8ce3a1a496f97083cba005e0bea938fdb1a66dce75::adaptor {
    struct ScallopAdaptor has drop {
        dummy_field: bool,
    }

    struct Deposited has copy, drop {
        amount_in: u64,
        amount_out: u64,
    }

    struct Withdrawn has copy, drop {
        amount_in: u64,
        amount_out: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T1, T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        let v0 = ScallopAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<ScallopAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<ScallopAdaptor, T0, T1>(v0, arg4, arg5), arg7);
        let v3 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T1, T0>(arg3, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, v1, arg6, arg7), arg7);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = ScallopAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<ScallopAdaptor, T0, T1>(arg0, v2, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<ScallopAdaptor, T0, T1>(v5, arg4, v4), v3);
        let v6 = Deposited{
            amount_in  : arg4,
            amount_out : v4,
        };
        0x2::event::emit<Deposited>(v6);
    }

    public fun withdraw<T0, T1>(arg0: &mut 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::wallet::Wallet, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        let v0 = ScallopAdaptor{dummy_field: false};
        let (v1, v2) = 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::validate_and_swap_out<ScallopAdaptor, T0, T1>(arg0, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::request_swap<ScallopAdaptor, T0, T1>(v0, arg4, arg5), arg7);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg1, arg2, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg3, v1, arg7), arg6, arg7);
        let v4 = 0x2::coin::value<T1>(&v3);
        let v5 = ScallopAdaptor{dummy_field: false};
        0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::verify_swap_and_credit<ScallopAdaptor, T0, T1>(arg0, v2, 0x24434ef7d9e99049d969974717bbd7b920d3453c5628ee344822709ca66d1de0::intent::create_swap_receipt<ScallopAdaptor, T0, T1>(v5, arg4, v4), v3);
        let v6 = Withdrawn{
            amount_in  : arg4,
            amount_out : v4,
        };
        0x2::event::emit<Withdrawn>(v6);
    }

    // decompiled from Move bytecode v7
}

