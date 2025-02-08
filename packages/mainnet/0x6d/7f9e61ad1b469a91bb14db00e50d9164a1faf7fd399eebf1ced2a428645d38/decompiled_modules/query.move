module 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::query {
    struct VaultInfo has copy, drop {
        is_running: bool,
        timestamp: u64,
    }

    struct BucketCDPInfo has copy, drop {
        coll_amount: u64,
        debt_amount: u64,
        oracle_price: u64,
    }

    struct CetusLPInfo has copy, drop {
        sui_amount: u64,
        buck_amount: u64,
        pool_sqrt_price: u128,
    }

    public fun bucket_cdp(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg3: &0x2::clock::Clock) {
        if (0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::is_running<0x2::sui::SUI>(arg2)) {
            let (v0, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::get_bottle_info_with_interest_by_debtor<0x2::sui::SUI>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<0x2::sui::SUI>(0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::borrow_strap<0x2::sui::SUI>(arg2)), arg3);
            let (v2, _) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x2::sui::SUI>(arg1, arg3);
            let v4 = BucketCDPInfo{
                coll_amount  : v0,
                debt_amount  : v1,
                oracle_price : v2,
            };
            0x2::event::emit<BucketCDPInfo>(v4);
        };
    }

    public fun vault(arg0: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>, arg1: &0x2::clock::Clock) {
        let v0 = VaultInfo{
            is_running : 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::is_running<0x2::sui::SUI>(arg0),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<VaultInfo>(v0);
    }

    public fun cetus_position(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>, arg1: &0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::Vault<0x2::sui::SUI>) {
        if (0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::is_running<0x2::sui::SUI>(arg1)) {
            let v0 = 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault::borrow_position<0x2::sui::SUI>(arg1);
            let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v0);
            let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), false);
            let v5 = CetusLPInfo{
                sui_amount      : v4,
                buck_amount     : v3,
                pool_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0x2::sui::SUI>(arg0),
            };
            0x2::event::emit<CetusLPInfo>(v5);
        };
    }

    // decompiled from Move bytecode v6
}

