module 0x1c2740b75e06bf7bcee49d6df216f8a069c00e86173a021da712c37de2eb84af::navi_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        index_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
    }

    public fun add_asset_index<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u8) {
        0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg1.index_map, 0x1::type_name::get<T0>(), arg2);
    }

    fun base_u256() : u256 {
        10
    }

    fun err_coin_type_not_supported() {
        abort 0
    }

    fun err_not_valid_price() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg0),
            index_map : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_asset_index<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u8>(&mut arg1.index_map, &v0);
    }

    public fun update_price<T0>(arg0: &Config, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.index_map, &v0)) {
            err_coin_type_not_supported();
        };
        let (v1, v2, v3) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg3, arg1, *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.index_map, &v0));
        if (!v1) {
            err_not_valid_price();
        };
        let v4 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<T0, Rule>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<T0>(arg2), v4, arg3, ((v2 * (0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<T0>(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle<T0>(arg2)) as u256) / 0x1::u256::pow(base_u256(), v3)) as u64));
    }

    // decompiled from Move bytecode v6
}

