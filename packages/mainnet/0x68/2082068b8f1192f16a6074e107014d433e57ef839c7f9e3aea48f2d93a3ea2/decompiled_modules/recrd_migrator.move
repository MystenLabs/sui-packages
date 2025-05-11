module 0x682082068b8f1192f16a6074e107014d433e57ef839c7f9e3aea48f2d93a3ea2::recrd_migrator {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct RecrdConfig has key {
        id: 0x2::object::UID,
        initialize_price: u128,
        treasury: address,
        reward_value: u64,
    }

    struct PoolCreationCapKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct NewPool has copy, drop {
        pool: address,
        tick_spacing: u32,
        meme: 0x1::type_name::TypeName,
        sui_balance: u64,
        meme_balance: u64,
    }

    struct SetTreasury has copy, drop {
        pos0: address,
        pos1: address,
    }

    struct SetInitializePrice has copy, drop {
        pos0: u128,
        pos1: u128,
    }

    struct SetRewardValue has copy, drop {
        pos0: u64,
        pos1: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecrdConfig{
            id               : 0x2::object::new(arg0),
            initialize_price : 63901395939770060,
            treasury         : @0x0,
            reward_value     : 1000000000,
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RecrdConfig>(v0);
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate<T0>(arg0: &mut RecrdConfig, arg1: &0x2::clock::Clock, arg2: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::get_decimals<T0>(arg6) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg2) == 1000000000000000000, 1);
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::destroy<T0, 0x2::sui::SUI, Witness>(arg7, v0);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2_with_creation_cap<T0, 0x2::sui::SUI>(arg3, arg4, pool_creation_cap<T0>(arg0), 200, arg0.initialize_price, 0x1::string::utf8(b""), 4294523696, 443600, 0x2::coin::from_balance<T0>(v4, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg8), arg6, arg5, false, arg1, arg8);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v10);
        let v12 = NewPool{
            pool         : 0x2::object::id_to_address(&v11),
            tick_spacing : 200,
            meme         : 0x1::type_name::get<T0>(),
            sui_balance  : 0x2::balance::value<0x2::sui::SUI>(&v3) - 0x2::coin::value<0x2::sui::SUI>(&v8),
            meme_balance : 0x2::balance::value<T0>(&v4) - 0x2::coin::value<T0>(&v9),
        };
        0x2::event::emit<NewPool>(v12);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v10, @0x0);
        transfer_or_burn<T0>(v9, @0x0);
        transfer_or_burn<0x2::sui::SUI>(v8, arg0.treasury);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg0.reward_value), arg8)
    }

    fun pool_creation_cap<T0>(arg0: &RecrdConfig) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap {
        let v0 = PoolCreationCapKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_object_field::borrow<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.id, v0)
    }

    public fun register_pool<T0>(arg0: &mut RecrdConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg1, arg2, arg3, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg1, arg2, 200, &v0, arg4);
        save_pool_creation_cap<T0>(arg0, v0);
    }

    fun save_pool_creation_cap<T0>(arg0: &mut RecrdConfig, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap) {
        let v0 = PoolCreationCapKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_object_field::add<PoolCreationCapKey, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.id, v0, arg1);
    }

    public fun set_initialize_price(arg0: &mut RecrdConfig, arg1: &Admin, arg2: u128) {
        assert!(arg2 != 0, 13906834951732461567);
        let v0 = SetInitializePrice{
            pos0 : arg0.initialize_price,
            pos1 : arg2,
        };
        0x2::event::emit<SetInitializePrice>(v0);
        arg0.initialize_price = arg2;
    }

    public fun set_reward_value(arg0: &mut RecrdConfig, arg1: &Admin, arg2: u64) {
        let v0 = SetRewardValue{
            pos0 : arg0.reward_value,
            pos1 : arg2,
        };
        0x2::event::emit<SetRewardValue>(v0);
        arg0.reward_value = arg2;
    }

    public fun set_treasury(arg0: &mut RecrdConfig, arg1: &Admin, arg2: address) {
        let v0 = SetTreasury{
            pos0 : arg0.treasury,
            pos1 : arg2,
        };
        0x2::event::emit<SetTreasury>(v0);
        arg0.treasury = arg2;
    }

    fun transfer_or_burn<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

