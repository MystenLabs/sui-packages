module 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::stonker {
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
        a0838fe09e8397d56: 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::ad9e4d11aecc532fa::Ad1f26f3c041612f2,
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

    struct Aac56ae4c64df67f8 has copy, drop {
        aef66ea9fdfdf6d38: address,
        a86c7a35a03090ccf: u64,
        ab48a9f34af22058d: u8,
        aa6e55145993bf678: u8,
        timestamp_ms: u64,
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

    fun a1d4036cdf86e784c(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.ab8476b265af11cba == 0x2::object::id<0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64>(arg1), 13906835544437948415);
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::a1d4036cdf86e784c(arg1, arg2);
    }

    public fun a280ecc58e70fd664(arg0: &Aeddd137dc4eebbc7) : (u64, u64) {
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::ad9e4d11aecc532fa::a280ecc58e70fd664(&arg0.a0838fe09e8397d56)
    }

    public fun a04e8527ac30a638d(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
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

    public fun a191fc0801353335f(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg14);
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::acbdd009a143591b1::a3b1c162091168a1d(arg2, &mut arg0.a0838fe09e8397d56, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun a1f5fd978b5985dae(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_all_orders<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, arg6, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::post_only(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::cancel_taker(), arg5, arg4, true, false, 0x2::clock::timestamp_ms(arg6) + 10000000000, arg6, arg7);
    }

    fun a34d481028643c775(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x2::sui::SUI>(arg3) >= 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::ab3241576c7b31a2f(arg1)) {
            return
        };
        let v0 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::a56fd38bb12b204a1(arg1) - 0x2::coin::value<0x2::sui::SUI>(arg3);
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

    public fun a3719153fb341de96(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::ad9e4d11aecc532fa::Ad1f26f3c041612f2 {
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

    public fun a70ee47026d9ceb87(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
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
            0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::a8ca7876854a16d35(arg1)
        } else {
            0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::abc3ae4f61d07f772(arg1)
        };
        let v1 = v0;
        let v2 = Aeddd137dc4eebbc7{
            id                : 0x2::object::new(arg1),
            ab8476b265af11cba : 0x2::object::id<0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64>(&v1),
            a754d038c79347e98 : 0,
            a2002058da000bc7e : 0,
            a48c4c6d74948f4f7 : 0,
            ac6f0e10915f54802 : 0,
            aef8bc71047dd2361 : 0,
            aac8da939a55f9e08 : 0,
            a0ee193d93f88cdcb : 0,
            a0838fe09e8397d56 : 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::ad9e4d11aecc532fa::a75d4519aec44b4ef(),
        };
        0x2::transfer::share_object<Aeddd137dc4eebbc7>(v2);
        0x2::transfer::public_share_object<0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64>(v1);
    }

    public fun aa32b4d17fa63d0ec(arg0: &Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg7);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg7);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg2, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg5, arg4, true, false, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg7);
    }

    public fun aa3c9ef1b6ba5d70b(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
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

    public fun aaf6cc9d45ba0185f(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: &0x2::clock::Clock, arg17: u64, arg18: u64, arg19: u8, arg20: u64, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg22);
        a34d481028643c775(arg0, arg1, arg3, arg2, arg22);
        if (0x2::clock::timestamp_ms(arg16) >= arg21) {
            0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a0348b65991e38b83::a15c536f8ba435e85(b"expired");
            return
        };
        if (0x2::clock::timestamp_ms(arg16) < arg0.a0ee193d93f88cdcb) {
            0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a0348b65991e38b83::a15c536f8ba435e85(b"cannot_trade");
            return
        };
        if (arg20 > arg0.aac8da939a55f9e08) {
            arg0.ac6f0e10915f54802 = arg17;
            arg0.aef8bc71047dd2361 = arg18;
            arg0.aac8da939a55f9e08 = arg20;
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg22);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, &v0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3);
        let v2 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::a2daef4381117fe2e(arg1, arg4, &v1, 8, arg16);
        let v3 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a1c61f525b4283a20::a95d889fec9e5f721(arg1, arg3, v1, &v2, arg0.ac6f0e10915f54802, arg16);
        let v4 = A06a3c5d6cb720767{
            a27ddd31886860775 : arg17,
            ac6f0e10915f54802 : arg0.ac6f0e10915f54802,
            ab857dba7b77c5937 : arg0.aef8bc71047dd2361,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg16),
            a8fabacfbc9a53eab : arg0.a754d038c79347e98,
            a863166978b7b5c02 : arg19,
            a8c11751b5c54d9f3 : *0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::a49526e8be3cf123e(&v2),
            a4ad9d24a601f5a60 : *0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::aa784e08665117e43(&v2),
            a7995ce3041d46cb2 : *0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::afc35d9b0ccb52fbe(&v2),
            a52aea689b5e0eb4e : *0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::a650b4a54924e6b42(&v2),
            ac21553e7b18debdd : 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::a27d645b0fcb2dc75(&v2) - 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::ad7573a5b071d6a42(&v2),
            ae5a8c85f7339c42f : arg20,
            a7d027a58611a0718 : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg3),
            a74b4e85f3b283ef9 : arg21,
        };
        0x2::event::emit<A06a3c5d6cb720767>(v4);
        arg0.a754d038c79347e98 = arg0.a754d038c79347e98 + 1;
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a1c61f525b4283a20::a38a80653e93a075b(&mut v3, arg1, arg3, &v0, arg4, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg0.ac6f0e10915f54802, arg0.aef8bc71047dd2361, &v2, arg22);
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::acbdd009a143591b1::a40f8bc58a06c8b33(arg1, &mut arg0.a0838fe09e8397d56, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg0.ac6f0e10915f54802, arg0.aef8bc71047dd2361, arg16, arg22);
        0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a2f7a3f8250aae687::adc6afbc22cb36f39(arg1, &mut v3, arg3, &v0, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg4, arg0.ac6f0e10915f54802, &mut arg0.a48c4c6d74948f4f7, arg16, arg22);
        if (arg19 == 0 || arg19 == 1) {
            0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a0348b65991e38b83::a4f6e7e0f807d8009(arg1, &mut v3, arg3, arg4, &v0, arg5, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg0.ac6f0e10915f54802, arg19 == 0, &v2, &mut arg0.a2002058da000bc7e, arg22);
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
        let (v3, v4) = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::ad9e4d11aecc532fa::a280ecc58e70fd664(&arg0.a0838fe09e8397d56);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg1) + v0 + v4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1) + v1 + v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1))
    }

    public fun ad78ba383d0c21891(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::claim_rebates<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg0, &v0, arg2);
    }

    public fun af8d2e978c17aee39(arg0: &mut Aeddd137dc4eebbc7, arg1: &0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a783956f993d811bc::A0ea878587b719a64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg12: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg13: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg14: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg15: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg16: &0x2::clock::Clock, arg17: u64, arg18: u64, arg19: u8, arg20: u64, arg21: u64, arg22: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg23: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg24: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg25: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg26: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg27: &mut 0x3::sui_system::SuiSystemState, arg28: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg29: u8, arg30: u8, arg31: vector<address>, arg32: vector<u64>, arg33: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg34: &mut 0x2::tx_context::TxContext) {
        a1d4036cdf86e784c(arg0, arg1, arg34);
        a34d481028643c775(arg0, arg1, arg3, arg2, arg34);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg34);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3, &v0);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_account_order_details<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg3);
        let v2 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::aaeb58f742bb7d09d::a2daef4381117fe2e(arg1, arg4, &v1, 8, arg16);
        arg0.ac6f0e10915f54802 = arg17;
        let v3 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a1c61f525b4283a20::a95d889fec9e5f721(arg1, arg3, v1, &v2, arg0.ac6f0e10915f54802, arg16);
        let v4 = 0x1::vector::length<address>(&arg31);
        assert!(v4 == 0x1::vector::length<u64>(&arg32), 13906835845085659135);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = Aac56ae4c64df67f8{
                aef66ea9fdfdf6d38 : *0x1::vector::borrow<address>(&arg31, v5),
                a86c7a35a03090ccf : *0x1::vector::borrow<u64>(&arg32, v5),
                ab48a9f34af22058d : arg29,
                aa6e55145993bf678 : arg30,
                timestamp_ms      : 0x2::clock::timestamp_ms(arg16),
            };
            0x2::event::emit<Aac56ae4c64df67f8>(v6);
            v5 = v5 + 1;
        };
        if (arg30 == 0 && arg29 == 10) {
            let v7 = 0;
            while (v7 < v4) {
                let v8 = *0x1::vector::borrow<u64>(&arg32, v7);
                0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::acbdd009a143591b1::a3b1c162091168a1d(arg3, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg34);
                0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a1c61f525b4283a20::a7b7e6cc5534d020a(&mut v3, arg1, arg3, &v0, arg4, &mut arg0.a0838fe09e8397d56, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a10868438248226c1::abe7ab0b8cf6b9d08(arg1, v8, arg17 * 9900 / 10000), arg16, arg34);
                let v9 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg3);
                if (!(v9 >= v8)) {
                    let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg34);
                    let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap_v2<0x2::sui::SUI>(arg33, arg28, v8 - v9, &v10, arg27, arg34);
                    let v13 = v12;
                    let v14 = v11;
                    let (_, _, _, _, v19, v20) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<0x2::sui::SUI>(&v13);
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v14, arg34), arg34);
                    let v21 = 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a2ec4300f6df080d1::a099d08408fdb4a75(1);
                    let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg10, arg9, false, true, 0x2::balance::value<0x2::sui::SUI>(&v14) + v19 + v20, 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a2ec4300f6df080d1::a213fd2a6b463b66d(&v21, 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a2ec4300f6df080d1::a8a8b4bfff2e7f9e6(&v21, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg17 * 99 / 100), arg16);
                    let v25 = v24;
                    let v26 = v23;
                    0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v22, arg34), arg34);
                    let v27 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v25) - 0x2::balance::value<0x2::sui::SUI>(&v26), arg34);
                    0x2::coin::join<0x2::sui::SUI>(&mut v27, 0x2::coin::from_balance<0x2::sui::SUI>(v26, arg34));
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg10, arg9, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x2::coin::into_balance<0x2::sui::SUI>(v27), v25);
                    let (v28, v29) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg16, arg23, arg22, arg29, arg24, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x1::u64::min(v8, 0x3807eee2447e0e8886841aab7ad9e2a30713d12fae5bfaf1d2146cb4d3bb7303::a10868438248226c1::a9d9f98ebd95b9dad(arg1, arg3)), arg34)), arg30, arg28, *0x1::vector::borrow<address>(&arg31, v7), arg25, arg26, arg27, arg34);
                    let v30 = v29;
                    let v31 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg16, arg22, arg28, v13, v28, &v10);
                    0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::delete_account(v10);
                    if (0x2::balance::value<0x2::sui::SUI>(&v31) > 0) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v31, arg34), arg34);
                    } else {
                        0x2::balance::destroy_zero<0x2::sui::SUI>(v31);
                    };
                    if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v30) > 0) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v30, arg34), arg34);
                    } else {
                        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v30);
                    };
                } else {
                    let (v32, v33) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg16, arg23, arg22, arg29, arg24, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x1::u64::min(v8, v9), arg34)), arg30, arg28, *0x1::vector::borrow<address>(&arg31, v7), arg25, arg26, arg27, arg34);
                    let v34 = v33;
                    let v35 = v32;
                    if (0x2::balance::value<0x2::sui::SUI>(&v35) > 0) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0x2::sui::SUI>(arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v35, arg34), arg34);
                    } else {
                        0x2::balance::destroy_zero<0x2::sui::SUI>(v35);
                    };
                    if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v34) > 0) {
                        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v34, arg34), arg34);
                    } else {
                        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v34);
                    };
                };
                v7 = v7 + 1;
            };
        };
        aaf6cc9d45ba0185f(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg34);
    }

    // decompiled from Move bytecode v6
}

