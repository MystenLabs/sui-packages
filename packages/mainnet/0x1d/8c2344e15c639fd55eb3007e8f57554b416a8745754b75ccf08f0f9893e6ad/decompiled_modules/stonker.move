module 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::stonker {
    struct Aeddd137dc4eebbc7 has store, key {
        id: 0x2::object::UID,
        ab8476b265af11cba: 0x2::object::ID,
        a754d038c79347e98: u64,
        a2002058da000bc7e: u64,
        a48c4c6d74948f4f7: u64,
        ac6f0e10915f54802: u64,
        aef8bc71047dd2361: u64,
        aac8da939a55f9e08: u64,
        a0ee193d93f88cdcb: u64,
        a0838fe09e8397d56: 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::ad9e4d11aecc532fa::Ad1f26f3c041612f2,
    }

    struct A429c253f9c82f901 has copy, drop {
        a1edd22467011c17c: u64,
        ae074fac5f2e4c7f4: u64,
        a4d30d340ccd5cd3f: bool,
        a0f243a04b2272ced: bool,
    }

    struct A9c97ee6f3ba795e6 has copy, drop {
        a475df970d477fe18: u64,
        a19456ed1c0e43a76: u64,
    }

    struct A06a3c5d6cb720767 has copy, drop {
        a27ddd31886860775: u64,
        ac6f0e10915f54802: u64,
        ab857dba7b77c5937: u64,
        timestamp_ms: u64,
        a8fabacfbc9a53eab: u64,
        a863166978b7b5c02: u8,
        a8c11751b5c54d9f3: vector<u64>,
        a4ad9d24a601f5a60: vector<u64>,
        a7995ce3041d46cb2: vector<u64>,
        a52aea689b5e0eb4e: vector<u64>,
        ac21553e7b18debdd: u64,
        ae5a8c85f7339c42f: u64,
        a7d027a58611a0718: 0x2::object::ID,
        a74b4e85f3b283ef9: u64,
    }

    struct Aa51a1efe266fb3e8 has copy, drop {
        aa90faafa2044fb28: u64,
    }

    fun a1d4036cdf86e784c(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.ab8476b265af11cba == 0x2::object::id<0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64>(arg1), 13906835389819125759);
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::a1d4036cdf86e784c(arg1, arg2);
    }

    public fun a280ecc58e70fd664(arg0: &Aeddd137dc4eebbc7) : (u64, u64) {
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::ad9e4d11aecc532fa::a280ecc58e70fd664(&arg0.a0838fe09e8397d56)
    }

    public fun a04e8527ac30a638d(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, arg4, false, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg7);
    }

    public fun a056c3387b3bdf4d7(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg0, 0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3), arg3);
        let v0 = A429c253f9c82f901{
            a1edd22467011c17c : arg2,
            ae074fac5f2e4c7f4 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg0),
            a4d30d340ccd5cd3f : true,
            a0f243a04b2272ced : true,
        };
        0x2::event::emit<A429c253f9c82f901>(v0);
    }

    public fun a12d5bef93f7eb6cc(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        let v0 = A429c253f9c82f901{
            a1edd22467011c17c : arg1,
            ae074fac5f2e4c7f4 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg0),
            a4d30d340ccd5cd3f : true,
            a0f243a04b2272ced : false,
        };
        0x2::event::emit<A429c253f9c82f901>(v0);
    }

    public fun a191fc0801353335f(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg11: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg13);
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::acbdd009a143591b1::a3b1c162091168a1d(arg2, &mut arg0.a0838fe09e8397d56, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun a1f5fd978b5985dae(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, arg6, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg5, arg4, true, false, 0x2::clock::timestamp_ms(arg6) + 10000000000, arg6, arg7);
    }

    fun a34d481028643c775(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x2::sui::SUI>(arg3) >= 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::ab3241576c7b31a2f(arg1)) {
            return
        };
        let v0 = 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::a56fd38bb12b204a1(arg1) - 0x2::coin::value<0x2::sui::SUI>(arg3);
        let v1 = v0;
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2);
        if (v2 < v0) {
            v1 = v2;
        };
        let v3 = A9c97ee6f3ba795e6{
            a475df970d477fe18 : v2,
            a19456ed1c0e43a76 : v1,
        };
        0x2::event::emit<A9c97ee6f3ba795e6>(v3);
        if (v1 == 0) {
            return
        };
        0x2::coin::join<0x2::sui::SUI>(arg3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg2, v1, arg4));
    }

    public fun a3719153fb341de96(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::ad9e4d11aecc532fa::Ad1f26f3c041612f2 {
        a1d4036cdf86e784c(arg0, arg1, arg2);
        &mut arg0.a0838fe09e8397d56
    }

    public fun a4e74b1aa8f3ee28c(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::stake<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0, &v0, arg2, arg3);
    }

    public fun a5fc836d28018dc95(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg2, true, false, 0x2::clock::timestamp_ms(arg4) + 1000, arg4, arg5);
    }

    public fun a70ee47026d9ceb87(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, arg6, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg5, arg4, false, false, 0x2::clock::timestamp_ms(arg6) + 10000000000, arg6, arg7);
    }

    public fun a8efb7684f410b8c4(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, 0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3), arg3);
        let v0 = A429c253f9c82f901{
            a1edd22467011c17c : arg2,
            ae074fac5f2e4c7f4 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0),
            a4d30d340ccd5cd3f : false,
            a0f243a04b2272ced : true,
        };
        0x2::event::emit<A429c253f9c82f901>(v0);
    }

    public fun a9b55de7468f00555(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0) {
            0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::a8ca7876854a16d35(arg1)
        } else {
            0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::abc3ae4f61d07f772(arg1)
        };
        let v1 = v0;
        let v2 = Aeddd137dc4eebbc7{
            id                : 0x2::object::new(arg1),
            ab8476b265af11cba : 0x2::object::id<0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64>(&v1),
            a754d038c79347e98 : 0,
            a2002058da000bc7e : 0,
            a48c4c6d74948f4f7 : 0,
            ac6f0e10915f54802 : 0,
            aef8bc71047dd2361 : 0,
            aac8da939a55f9e08 : 0,
            a0ee193d93f88cdcb : 0,
            a0838fe09e8397d56 : 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::ad9e4d11aecc532fa::a75d4519aec44b4ef(),
        };
        0x2::transfer::share_object<Aeddd137dc4eebbc7>(v2);
        0x2::transfer::public_share_object<0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64>(v1);
    }

    public fun aa32b4d17fa63d0ec(arg0: &Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, arg4, true, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg7);
    }

    public fun aa3c9ef1b6ba5d70b(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg8);
        a34d481028643c775(arg0, arg1, arg3, arg2, arg8);
        if (0x2::clock::timestamp_ms(arg5) >= arg7) {
            return
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, &v0, arg5, arg8);
        arg0.a0ee193d93f88cdcb = 0x2::clock::timestamp_ms(arg5) + arg6;
        let v1 = Aa51a1efe266fb3e8{aa90faafa2044fb28: arg6};
        0x2::event::emit<Aa51a1efe266fb3e8>(v1);
    }

    public fun aa449131c98b730b6(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0));
    }

    public fun aaf6cc9d45ba0185f(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg11: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg12: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg14: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg15: &0x2::clock::Clock, arg16: u64, arg17: u64, arg18: u8, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg21);
        a34d481028643c775(arg0, arg1, arg3, arg2, arg21);
        if (0x2::clock::timestamp_ms(arg15) >= arg20) {
            0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a0348b65991e38b83::a15c536f8ba435e85(b"expired");
            return
        };
        if (0x2::clock::timestamp_ms(arg15) < arg0.a0ee193d93f88cdcb) {
            0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a0348b65991e38b83::a15c536f8ba435e85(b"cannot_trade");
            return
        };
        if (arg19 > arg0.aac8da939a55f9e08) {
            arg0.ac6f0e10915f54802 = arg16;
            arg0.aef8bc71047dd2361 = arg17;
            arg0.aac8da939a55f9e08 = arg19;
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg21);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, &v0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3);
        let v2 = 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::a2daef4381117fe2e(arg1, arg4, &v1, 8, arg15);
        let v3 = 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a1c61f525b4283a20::a95d889fec9e5f721(arg1, arg3, v1, &v2, arg0.ac6f0e10915f54802, arg15);
        let v4 = A06a3c5d6cb720767{
            a27ddd31886860775 : arg16,
            ac6f0e10915f54802 : arg0.ac6f0e10915f54802,
            ab857dba7b77c5937 : arg0.aef8bc71047dd2361,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg15),
            a8fabacfbc9a53eab : arg0.a754d038c79347e98,
            a863166978b7b5c02 : arg18,
            a8c11751b5c54d9f3 : *0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::a49526e8be3cf123e(&v2),
            a4ad9d24a601f5a60 : *0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::aa784e08665117e43(&v2),
            a7995ce3041d46cb2 : *0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::afc35d9b0ccb52fbe(&v2),
            a52aea689b5e0eb4e : *0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::a650b4a54924e6b42(&v2),
            ac21553e7b18debdd : 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::a27d645b0fcb2dc75(&v2) - 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::aaeb58f742bb7d09d::ad7573a5b071d6a42(&v2),
            ae5a8c85f7339c42f : arg19,
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3),
            a74b4e85f3b283ef9 : arg20,
        };
        0x2::event::emit<A06a3c5d6cb720767>(v4);
        arg0.a754d038c79347e98 = arg0.a754d038c79347e98 + 1;
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a1c61f525b4283a20::a38a80653e93a075b(&mut v3, arg1, arg3, &v0, arg4, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg0.ac6f0e10915f54802, arg0.aef8bc71047dd2361, &v2, arg21);
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::acbdd009a143591b1::a40f8bc58a06c8b33(arg1, &mut arg0.a0838fe09e8397d56, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg0.ac6f0e10915f54802, arg15, arg21);
        0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a2f7a3f8250aae687::adc6afbc22cb36f39(arg1, &mut v3, arg3, &v0, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg4, arg0.ac6f0e10915f54802, &mut arg0.a48c4c6d74948f4f7, arg15, arg21);
        if (arg18 == 0 || arg18 == 1) {
            0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::a0348b65991e38b83::a4f6e7e0f807d8009(arg1, &mut v3, arg3, arg4, &v0, arg5, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg0.ac6f0e10915f54802, arg18 == 0, &v2, &mut arg0.a2002058da000bc7e, arg21);
        };
    }

    public fun ac6dea4ca45018666(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
        let v0 = A429c253f9c82f901{
            a1edd22467011c17c : arg1,
            ae074fac5f2e4c7f4 : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0),
            a4d30d340ccd5cd3f : false,
            a0f243a04b2272ced : false,
        };
        0x2::event::emit<A429c253f9c82f901>(v0);
    }

    public fun acf625dd2d0d91c0e(arg0: &Aeddd137dc4eebbc7, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : (u64, u64, u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1);
        let (v3, v4) = 0x1d8c2344e15c639fd55eb3007e8f57554b416a8745754b75ccf08f0f9893e6ad::ad9e4d11aecc532fa::a280ecc58e70fd664(&arg0.a0838fe09e8397d56);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1) + v0 + v4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1) + v1 + v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1))
    }

    public fun ad78ba383d0c21891(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::claim_rebates<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0, &v0, arg2);
    }

    // decompiled from Move bytecode v6
}

