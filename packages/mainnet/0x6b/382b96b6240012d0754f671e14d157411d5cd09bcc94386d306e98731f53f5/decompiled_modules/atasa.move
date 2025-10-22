module 0x6b382b96b6240012d0754f671e14d157411d5cd09bcc94386d306e98731f53f5::atasa {
    struct ATASA has drop {
        dummy_field: bool,
    }

    public fun add_liquidity_to_pool(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<ATASA, 0x2::sui::SUI>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::balance::Balance<ATASA>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u128, arg6: &0x2::clock::Clock) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<ATASA, 0x2::sui::SUI>(arg0, arg1, arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<ATASA, 0x2::sui::SUI>(arg0, arg1, arg2, arg5, arg6));
    }

    public fun atasa_pool(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: u32, arg3: u128, arg4: 0x2::coin::Coin<ATASA>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<ATASA, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, 0x1::string::utf8(b"https://res.cloudinary.com/georgegoldman/image/upload/v1761138954/WhatsApp_Image_2025-10-21_at_1.18.20_PM_xuuhtm.jpg"), 1, 6, arg4, arg5, true, arg6, arg7);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<ATASA>>(v1, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg7));
    }

    public fun create_coin(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        abort 404
    }

    fun init(arg0: ATASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ATASA>(arg0, 6, 0x1::string::utf8(b"ATS"), 0x1::string::utf8(b"ATASA"), 0x1::string::utf8(b"energy coin by sui hub"), 0x1::string::utf8(b"https://res.cloudinary.com/georgegoldman/image/upload/v1761138954/WhatsApp_Image_2025-10-21_at_1.18.20_PM_xuuhtm.jpg"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<ATASA>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ATASA>>(0x2::coin_registry::finalize<ATASA>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ATASA>>(0x2::coin::mint<ATASA>(&mut v2, 27, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun share_atasa(arg0: &mut 0x2::coin::Coin<ATASA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ATASA>>(0x2::coin::split<ATASA>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

