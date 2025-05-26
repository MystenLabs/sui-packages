module 0xe0b84b189f5d979d62976a74da646cf3f8a0ec2958263b9be612de21100b257e::codelab {
    struct RebalanceToCex has copy, drop {
        operator: address,
        amount: u64,
        to_address: address,
        token: 0x1::type_name::TypeName,
    }

    struct BuyToAlphaEvent has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        account_id: u256,
        cloud_wallet: address,
    }

    struct SellToSelfFromAlpha has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        withdraw_id: u256,
        cloud_wallet: address,
    }

    public fun buy_to_alpha_multi_hop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg4: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg5: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg6: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        123
    }

    public fun test_param1<T0, T1, T2>(arg0: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>, arg2: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>, arg3: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        111
    }

    public fun test_param11<T0, T1, T2>(arg0: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg0)) {
            0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0);
    }

    public fun test_param12<T0, T1, T2>(arg0: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg0)) {
            0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0));
        } else {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0);
        };
    }

    public fun test_param13<T0, T1, T2>(arg0: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg0)) {
            0x1::option::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&mut arg0);
            0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(0x1::option::destroy_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0));
        } else {
            0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0);
        };
    }

    public fun test_param2<T0, T1, T2>(arg0: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0)) {
            111
        } else {
            222
        }
    }

    public fun test_param3<T0, T1, T2>(arg0: &mut 0x2::tx_context::TxContext) : u64 {
        333
    }

    public fun test_param4<T0, T1, T2>(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun test_param5<T0, T1, T2>(arg0: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun test_param6<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        666
    }

    public fun test_param7<T0, T1, T2>(arg0: &mut 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0));
        777
    }

    public fun test_param8<T0, T1, T2>(arg0: &0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        888
    }

    public fun test_param9<T0, T1, T2>(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0);
        999
    }

    // decompiled from Move bytecode v6
}

