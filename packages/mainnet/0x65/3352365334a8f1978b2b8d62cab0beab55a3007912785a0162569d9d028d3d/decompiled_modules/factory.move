module 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::factory {
    struct YourStableFactory has drop {
        dummy_field: bool,
    }

    struct Factory<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        beneficiary: 0x2::vec_set::VecSet<address>,
        underlying_balance: 0x2::balance::Balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>,
        basic_supply: 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply,
        extension_supplies: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>,
    }

    struct FactoryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0>(arg0: &mut Factory<T0>, arg1: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg6: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::Strategy, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = burn_<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v0, arg9)
    }

    public fun mint<T0, T1>(arg0: &mut Factory<T1>, arg1: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir<T0>(arg3, 0x2::coin::into_balance<T0>(arg5));
        let v1 = from_normalized_amount<T1>(arg0, 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v0));
        let v2 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::deposit<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg2, v0, arg4);
        0x2::balance::join<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&mut arg0.underlying_balance, v2);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::increase(&mut arg0.basic_supply, v1);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_mint_your_stable_event<T1>(0x2::object::id<Factory<T1>>(arg0), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(&arg5), v1, 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&v2), basic_supply<T1>(arg0), 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance));
        0x2::coin::mint<T1>(borrow_cap_mut<T1>(arg0), v1, arg6)
    }

    public fun total_supply<T0>(arg0: &Factory<T0>) : u64 {
        0x2::coin::total_supply<T0>(borrow_cap<T0>(arg0))
    }

    public fun new<T0>(arg0: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::registry::Registry, arg1: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Factory<T0>, FactoryCap<T0>) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = 0x2::object::new(arg5);
        0x2::dynamic_object_field::add<0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::cap_key(), arg2);
        let v1 = 0x2::coin::get_decimals<T0>(arg3);
        let v2 = Factory<T0>{
            id                 : v0,
            decimals           : v1,
            beneficiary        : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg5)),
            underlying_balance : 0x2::balance::zero<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(),
            basic_supply       : 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::new(arg4),
            extension_supplies : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(),
        };
        let v3 = FactoryCap<T0>{id: 0x2::object::new(arg5)};
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_new_factory_event<T0>(0x2::object::id<Factory<T0>>(&v2), 0x2::object::id<FactoryCap<T0>>(&v3), 0x1::type_name::get<T0>(), v1, arg4);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::registry::register<T0>(arg0, 0x2::object::id<Factory<T0>>(&v2), 0x2::object::id<FactoryCap<T0>>(&v3));
        (v2, v3)
    }

    public fun set_basic_limit<T0>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg3: u64) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg2);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::set_limit(&mut arg1.basic_supply, arg3);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::set_basic_limit<T0>(0x2::object::id<Factory<T0>>(arg1), arg3);
    }

    public fun set_extension_limit<T0, T1: drop>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg3: u64) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg2);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&arg1.extension_supplies, &v0)) {
            0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::set_limit(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&mut arg1.extension_supplies, &v0), arg3);
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&mut arg1.extension_supplies, v0, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::new(arg3));
        };
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::set_extension_limit<T0>(0x2::object::id<Factory<T0>>(arg1), 0x1::type_name::get<T1>(), arg3);
    }

    public fun update_metadata<T0>(arg0: &FactoryCap<T0>, arg1: &Factory<T0>, arg2: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg3: &mut 0x2::coin::CoinMetadata<T0>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::ascii::String>) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg2);
        let v0 = borrow_cap<T0>(arg1);
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            0x2::coin::update_name<T0>(v0, arg3, 0x1::option::destroy_some<0x1::string::String>(arg4));
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg4);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg5)) {
            0x2::coin::update_symbol<T0>(v0, arg3, 0x1::option::destroy_some<0x1::ascii::String>(arg5));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(arg5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            0x2::coin::update_description<T0>(v0, arg3, 0x1::option::destroy_some<0x1::string::String>(arg6));
        } else {
            0x1::option::destroy_none<0x1::string::String>(arg6);
        };
        if (0x1::option::is_some<0x1::ascii::String>(&arg7)) {
            0x2::coin::update_icon_url<T0>(v0, arg3, 0x1::option::destroy_some<0x1::ascii::String>(arg7));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(arg7);
        };
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::update_metadata<T0>(0x2::object::id<Factory<T0>>(arg1), 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3), arg4, arg5, arg6, arg7);
    }

    public fun add_beneficiary<T0>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg3: address) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg2);
        if (!0x2::vec_set::contains<address>(&arg1.beneficiary, &arg3)) {
            0x2::vec_set::insert<address>(&mut arg1.beneficiary, arg3);
        };
    }

    public fun basic_supply<T0>(arg0: &Factory<T0>) : u64 {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::supply(&arg0.basic_supply)
    }

    fun borrow_cap<T0>(arg0: &Factory<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow<0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::cap_key())
    }

    fun borrow_cap_mut<T0>(arg0: &mut Factory<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::cap_key::cap_key())
    }

    fun burn_<T0, T1>(arg0: &mut Factory<T1>, arg1: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg6: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::Strategy, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        let v0 = 0x2::coin::value<T1>(&arg8);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::decrease(&mut arg0.basic_supply, v0);
        let v1 = borrow_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v1, arg8);
        let v2 = to_normalized_amount<T1>(arg0, v0);
        let v3 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::withdraw_t_amt<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg3, v2, &mut arg0.underlying_balance, arg7);
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::withdraw_v1(arg6, arg2, arg5, arg4, &mut v3, arg7, arg9);
        let v4 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::redeem_withdraw_ticket<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg3, v3);
        let v5 = 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v4);
        if (v5 < v2) {
            0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v4, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::take_from_reserve(arg1, v2 - v5));
        };
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_burn_your_stable_event<T1>(0x2::object::id<Factory<T1>>(arg0), 0x1::type_name::get<T0>(), v0, 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance) - 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance), 0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v4), basic_supply<T1>(arg0), 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance));
        v4
    }

    public fun burn_and_redeem<T0, T1>(arg0: &mut Factory<T1>, arg1: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::redemption_queue::RedemptionQueue<T0, YourStableFactory>, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg4: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg5: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg6: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg7: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::Strategy, arg8: &0x2::clock::Clock, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = to_normalized_amount<T1>(arg0, 0x2::coin::value<T1>(&arg9));
        let v1 = burn_<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg12);
        let v2 = YourStableFactory{dummy_field: false};
        let v3 = 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::redemption_queue::request<T0, YourStableFactory>(v2, v0);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::redemption_queue::add_balance<T0, YourStableFactory>(&mut v3, 0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut v1, 0x1::u64::min(0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v1), to_normalized_amount<T1>(arg0, arg10))));
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::redemption_queue::create_ticket<T0, YourStableFactory>(arg2, arg8, v3, arg11);
        0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(v1, arg12)
    }

    public fun burn_with_extension<T0: drop, T1>(arg0: &mut Factory<T1>, arg1: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: T0, arg3: 0x2::coin::Coin<T1>) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&arg0.extension_supplies, &v0)) {
            err_invalid_extension_type();
        };
        let v1 = 0x2::coin::value<T1>(&arg3);
        let v2 = 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::decrease(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&mut arg0.extension_supplies, &v0), v1);
        let v3 = borrow_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v3, arg3);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_burn_your_stable_with_extension_event<T1>(0x2::object::id<Factory<T1>>(arg0), v0, v1, v2);
    }

    public fun claim_reward<T0>(arg0: &mut Factory<T0>, arg1: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::vec_set::contains<address>(&arg0.beneficiary, &v0)) {
            err_sender_is_not_beneficiary();
        };
        let v1 = 0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance) - underlying_reserve<T0>(arg0, arg2, arg3);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_claim_reward_event<T0>(0x2::object::id<Factory<T0>>(arg0), v1, 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(0x2::balance::split<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&mut arg0.underlying_balance, v1), arg4)
    }

    fun err_invalid_extension_type() {
        abort 1
    }

    fun err_sender_is_not_beneficiary() {
        abort 2
    }

    public fun extension_supplies<T0>(arg0: &Factory<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply> {
        &arg0.extension_supplies
    }

    public fun from_normalized_amount<T0>(arg0: &Factory<T0>, arg1: u64) : u64 {
        let v0 = your_stable_decimals<T0>(arg0);
        let v1 = underlying_decimals();
        if (v0 < v1) {
            arg1 / 0x1::u64::pow(10, v1 - v0)
        } else if (v0 > v1) {
            arg1 * 0x1::u64::pow(10, v0 - v1)
        } else {
            arg1
        }
    }

    public fun from_underlying_amount(arg0: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div(arg2, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0, arg1), 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0))
    }

    public fun get_rewards_amount<T0>(arg0: &mut Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance) - underlying_reserve<T0>(arg0, arg1, arg2)
    }

    public fun get_rewards_value<T0>(arg0: &mut Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_rewards_amount<T0>(arg0, arg1, arg2);
        if (v0 == 0 || 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1) == 0) {
            return 0
        };
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div(v0, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1, arg2), 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1))
    }

    public fun mint_with_extension<T0: drop, T1>(arg0: &mut Factory<T1>, arg1: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&arg0.extension_supplies, &v0)) {
            err_invalid_extension_type();
        };
        let v1 = borrow_cap_mut<T1>(arg0);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::event::emit_mint_your_stable_with_extension_event<T1>(0x2::object::id<Factory<T1>>(arg0), v0, arg3, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::increase(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::limited_supply::LimitedSupply>(&mut arg0.extension_supplies, &v0), arg3));
        0x2::coin::mint<T1>(v1, arg3, arg4)
    }

    public fun redeem<T0, T1>(arg0: &mut Factory<T1>, arg1: &mut 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg6: &mut 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::Strategy, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<T1>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg1);
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_is_whitelisted<T1>(arg1);
        let v0 = burn_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v1 = YourStableFactory{dummy_field: false};
        0x2::coin::from_balance<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<T0, YourStableFactory>(arg2, v0, v1), arg9)
    }

    public fun remove_beneficiary<T0>(arg0: &FactoryCap<T0>, arg1: &mut Factory<T0>, arg2: &0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::Config, arg3: address) {
        0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config::assert_package_version(arg2);
        if (0x2::vec_set::contains<address>(&arg1.beneficiary, &arg3)) {
            0x2::vec_set::remove<address>(&mut arg1.beneficiary, &arg3);
        };
    }

    public fun to_normalized_amount<T0>(arg0: &Factory<T0>, arg1: u64) : u64 {
        let v0 = your_stable_decimals<T0>(arg0);
        let v1 = underlying_decimals();
        if (v0 < v1) {
            arg1 * 0x1::u64::pow(10, v1 - v0)
        } else if (v0 > v1) {
            arg1 / 0x1::u64::pow(10, v0 - v1)
        } else {
            arg1
        }
    }

    public fun to_underlying_amount(arg0: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0, arg1);
        if (v0 == 0) {
            return 0
        };
        0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::utils::mul_div_round_up(arg2, 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg0), v0)
    }

    public fun underlying_balance<T0>(arg0: &Factory<T0>) : u64 {
        0x2::balance::value<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(&arg0.underlying_balance)
    }

    public fun underlying_decimals() : u8 {
        9
    }

    public fun underlying_reserve<T0>(arg0: &Factory<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock) : u64 {
        to_underlying_amount(arg1, arg2, to_normalized_amount<T0>(arg0, basic_supply<T0>(arg0)))
    }

    public fun your_stable_decimals<T0>(arg0: &Factory<T0>) : u8 {
        arg0.decimals
    }

    // decompiled from Move bytecode v6
}

