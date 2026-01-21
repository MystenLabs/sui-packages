module 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
        oracle_id: 0x2::object::ID,
    }

    struct PriceFeederCap has store, key {
        id: 0x2::object::UID,
        for_oracle: 0x2::object::ID,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        price_threshold_ratio: u64,
        default_price_expiry_seconds: u64,
        supported_pairs: 0x2::linked_table::LinkedTable<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>,
        prices: 0x2::table::Table<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>,
        version: u64,
    }

    struct AssetPair has copy, drop, store {
        base_name: 0x1::ascii::String,
        quote_name: 0x1::ascii::String,
        base_precision: u8,
        quote_precision: u8,
    }

    struct AssetPairResponse has copy, drop, store {
        pair: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair,
        info: AssetPair,
    }

    struct PriceData has copy, drop, store {
        price: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::RawPrice,
        last_updated_ms: u64,
        updater: address,
    }

    struct PriceResponse has copy, drop, store {
        pair_data: 0x1::option::Option<PriceData>,
        is_inverted: bool,
    }

    struct OracleCreated has copy, drop {
        oracle_id: 0x2::object::ID,
        admin_id: 0x2::object::ID,
    }

    struct OracleConfigUpdated has copy, drop {
        oracle_id: 0x2::object::ID,
        price_threshold_ratio: u64,
        default_price_expiry_seconds: u64,
    }

    struct PriceFeederCapMinted has copy, drop {
        oracle_id: 0x2::object::ID,
        price_feeder_id: 0x2::object::ID,
    }

    struct PriceFeederCapDeleted has copy, drop {
        oracle_id: 0x2::object::ID,
        price_feeder_id: 0x2::object::ID,
    }

    struct PriceUpdated<phantom T0, phantom T1> has copy, drop {
        oracle_id: 0x2::object::ID,
        price: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::Price<T0, T1>,
    }

    struct PriceReseted<phantom T0, phantom T1> has copy, drop {
        oracle_id: 0x2::object::ID,
        price: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::Price<T0, T1>,
    }

    struct AssetPairAdded<phantom T0, phantom T1> has copy, drop {
        oracle_id: 0x2::object::ID,
        base_name: 0x1::ascii::String,
        quote_name: 0x1::ascii::String,
        base_precision: u8,
        quote_precision: u8,
    }

    struct AssetPairRemoved<phantom T0, phantom T1> has copy, drop {
        oracle_id: 0x2::object::ID,
        base_name: 0x1::ascii::String,
        quote_name: 0x1::ascii::String,
    }

    struct AuthorityAdded has copy, drop {
        dummy_field: bool,
    }

    struct AuthorityRemoved has copy, drop {
        dummy_field: bool,
    }

    struct ConfigResponse has copy, drop, store {
        price_threshold_ratio: u64,
        default_price_expiry_seconds: u64,
    }

    public fun get_price<T0, T1>(arg0: &Oracle) : PriceResponse {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T1, T0>();
        let (v2, v3) = if (0x2::table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0))) {
            let v4 = 0x2::table::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0));
            (v4, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T0, T1>(&v4.price))
        } else if (0x2::table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T1, T0>(&v1))) {
            let v5 = 0x2::table::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T1, T0>(&v1));
            let v6 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T1, T0>(&v5.price);
            (v5, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_inverse_price<T1, T0>(&v6))
        } else {
            return PriceResponse{
                pair_data   : 0x1::option::none<PriceData>(),
                is_inverted : false,
            }
        };
        let v7 = v3;
        let v8 = PriceData{
            price           : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_raw<T0, T1>(&v7),
            last_updated_ms : v2.last_updated_ms,
            updater         : v2.updater,
        };
        PriceResponse{
            pair_data   : 0x1::option::some<PriceData>(v8),
            is_inverted : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::is_inversed<T0, T1>(&v7),
        }
    }

    public fun add_asset_pair<T0, T1>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::uid_to_inner(&arg0.id), 3000);
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        assert!(!0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0)), 3006);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T1, T0>();
        assert!(!0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T1, T0>(&v1)), 3007);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v4 = AssetPair{
            base_name       : v2,
            quote_name      : v3,
            base_precision  : arg2,
            quote_precision : arg3,
        };
        0x2::linked_table::push_back<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&mut arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0), v4);
        let v5 = AssetPairAdded<T0, T1>{
            oracle_id       : 0x2::object::uid_to_inner(&arg0.id),
            base_name       : v2,
            quote_name      : v3,
            base_precision  : arg2,
            quote_precision : arg3,
        };
        0x2::event::emit<AssetPairAdded<T0, T1>>(v5);
    }

    public fun asset_pair_response_pair(arg0: &AssetPairResponse) : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair {
        arg0.pair
    }

    public fun asset_pairs(arg0: &Oracle) : vector<AssetPairResponse> {
        let v0 = 0x1::vector::empty<AssetPairResponse>();
        let v1 = 0x2::linked_table::front<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs);
        while (0x1::option::is_some<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair>(v1)) {
            let v2 = *0x1::option::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair>(v1);
            let v3 = AssetPairResponse{
                pair : v2,
                info : *0x2::linked_table::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, v2),
            };
            0x1::vector::push_back<AssetPairResponse>(&mut v0, v3);
            v1 = 0x2::linked_table::next<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, v2);
        };
        v0
    }

    public fun check_asset_pair_exists<T0, T1>(arg0: &mut Oracle) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0))
    }

    public fun config(arg0: &Oracle) : ConfigResponse {
        ConfigResponse{
            price_threshold_ratio        : arg0.price_threshold_ratio,
            default_price_expiry_seconds : arg0.default_price_expiry_seconds,
        }
    }

    public fun config_into(arg0: &ConfigResponse) : (u64, u64) {
        (arg0.price_threshold_ratio, arg0.default_price_expiry_seconds)
    }

    public fun delete_price_feeder_cap(arg0: PriceFeederCap, arg1: &mut 0x2::tx_context::TxContext) {
        let PriceFeederCap {
            id         : v0,
            for_oracle : v1,
        } = arg0;
        let v2 = v0;
        let v3 = PriceFeederCapDeleted{
            oracle_id       : v1,
            price_feeder_id : 0x2::object::uid_to_inner(&v2),
        };
        0x2::event::emit<PriceFeederCapDeleted>(v3);
        0x2::object::delete(v2);
    }

    public fun get_inner_price<T0, T1>(arg0: &PriceData) : u128 {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T0, T1>(&arg0.price);
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v0)
    }

    public fun get_valid_price<T0, T1>(arg0: &Oracle, arg1: &0x2::clock::Clock) : (PriceData, bool) {
        let v0 = get_price<T0, T1>(arg0);
        assert!(0x1::option::is_some<PriceData>(&v0.pair_data), 3008);
        let v1 = *0x1::option::borrow<PriceData>(&v0.pair_data);
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T0, T1>(&v1.price);
        assert!(!0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::is_expired<T0, T1>(&v2, arg1), 3002);
        (v1, v0.is_inverted)
    }

    public fun initialize(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::ProtocolAdminCap, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        assert!((arg1 as u128) <= 10000, 3004);
        let v3 = Oracle{
            id                           : v1,
            price_threshold_ratio        : arg1,
            default_price_expiry_seconds : 0x1::option::get_with_default<u64>(&arg2, 300),
            supported_pairs              : 0x2::linked_table::new<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(arg4),
            prices                       : 0x2::table::new<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(arg4),
            version                      : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::constants::get_version(),
        };
        let v4 = OracleAdminCap{
            id        : 0x2::object::new(arg4),
            oracle_id : v2,
        };
        let v5 = OracleCreated{
            oracle_id : v2,
            admin_id  : 0x2::object::uid_to_inner(&v4.id),
        };
        0x2::event::emit<OracleCreated>(v5);
        mint_price_feeder_cap(&v3, &v4, arg3, arg4);
        0x2::transfer::share_object<Oracle>(v3);
        0x2::transfer::transfer<OracleAdminCap>(v4, v0);
    }

    fun internal_remove_asset_pair<T0, T1>(arg0: &mut Oracle, arg1: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::Pair<T0, T1>) : (0x1::ascii::String, 0x1::ascii::String) {
        let v0 = 0x2::linked_table::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&arg1));
        0x2::linked_table::remove<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&mut arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&arg1));
        (v0.base_name, v0.quote_name)
    }

    public fun mint_price_feeder_cap(arg0: &Oracle, arg1: &OracleAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::uid_to_inner(&arg0.id), 3000);
        let v0 = PriceFeederCap{
            id         : 0x2::object::new(arg3),
            for_oracle : 0x2::object::uid_to_inner(&arg0.id),
        };
        let v1 = PriceFeederCapMinted{
            oracle_id       : 0x2::object::uid_to_inner(&arg0.id),
            price_feeder_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<PriceFeederCapMinted>(v1);
        0x2::transfer::transfer<PriceFeederCap>(v0, arg2);
    }

    public fun price_data_last_updated(arg0: &PriceData) : u64 {
        arg0.last_updated_ms
    }

    public fun price_data_price<T0, T1>(arg0: &PriceData) : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::Price<T0, T1> {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T0, T1>(&arg0.price)
    }

    public fun price_response_pair_data(arg0: &PriceResponse) : 0x1::option::Option<PriceData> {
        arg0.pair_data
    }

    public fun remove_asset_pair<T0, T1>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::uid_to_inner(&arg0.id), 3000);
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T1, T0>();
        let (v2, v3) = if (0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0))) {
            internal_remove_asset_pair<T0, T1>(arg0, v0)
        } else {
            assert!(0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T1, T0>(&v1)), 3001);
            internal_remove_asset_pair<T1, T0>(arg0, v1)
        };
        let v4 = AssetPairRemoved<T0, T1>{
            oracle_id  : 0x2::object::uid_to_inner(&arg0.id),
            base_name  : v2,
            quote_name : v3,
        };
        0x2::event::emit<AssetPairRemoved<T0, T1>>(v4);
    }

    public fun reset_price<T0, T1>(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::new_price<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg3) - 1);
        assert!(0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0)), 3001);
        let v2 = PriceData{
            price           : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_raw<T0, T1>(&v1),
            last_updated_ms : 0x2::clock::timestamp_ms(arg3),
            updater         : 0x2::tx_context::sender(arg4),
        };
        assert!(0x2::table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0)), 3008);
        *0x2::table::borrow_mut<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&mut arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0)) = v2;
        let v3 = PriceReseted<T0, T1>{
            oracle_id : 0x2::object::uid_to_inner(&arg0.id),
            price     : v1,
        };
        0x2::event::emit<PriceReseted<T0, T1>>(v3);
    }

    public fun update_config(arg0: &mut Oracle, arg1: &OracleAdminCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.oracle_id == 0x2::object::uid_to_inner(&arg0.id), 3000);
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!((*0x1::option::borrow<u64>(&arg2) as u128) <= 10000, 3004);
            arg0.price_threshold_ratio = *0x1::option::borrow<u64>(&arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v0 = *0x1::option::borrow<u64>(&arg3);
            assert!(v0 > 0 && v0 <= 86400, 3004);
            arg0.default_price_expiry_seconds = *0x1::option::borrow<u64>(&arg3);
        };
        let v1 = OracleConfigUpdated{
            oracle_id                    : 0x2::object::uid_to_inner(&arg0.id),
            price_threshold_ratio        : arg0.price_threshold_ratio,
            default_price_expiry_seconds : arg0.default_price_expiry_seconds,
        };
        0x2::event::emit<OracleConfigUpdated>(v1);
    }

    public fun update_module_version(arg0: &mut Oracle) {
        assert!(arg0.version < 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::constants::get_version(), 3005);
        arg0.version = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::constants::get_version();
    }

    public fun update_price<T0, T1>(arg0: &mut Oracle, arg1: &PriceFeederCap, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.for_oracle == 0x2::object::uid_to_inner(&arg0.id), 3000);
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::new_pair<T0, T1>();
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::new_price<T0, T1>(arg2, 0x2::clock::timestamp_ms(arg4) + arg3);
        assert!(0x2::linked_table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, AssetPair>(&arg0.supported_pairs, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0)), 3001);
        let v2 = PriceData{
            price           : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_raw<T0, T1>(&v1),
            last_updated_ms : 0x2::clock::timestamp_ms(arg4),
            updater         : 0x2::tx_context::sender(arg5),
        };
        if (0x2::table::contains<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0))) {
            let v3 = 0x2::table::borrow_mut<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&mut arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0));
            let v4 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::into_price<T0, T1>(&v3.price);
            let v5 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v4);
            let v6 = (arg0.price_threshold_ratio as u128);
            let v7 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v1);
            assert!(v7 >= 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(v5, 10000 - v6, 10000) && v7 <= 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(v5, 10000 + v6, 10000), 3003);
            assert!(!0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::is_expired<T0, T1>(&v1, arg4), 3002);
            *v3 = v2;
        } else {
            0x2::table::add<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::RawPair, PriceData>(&mut arg0.prices, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_pair::get_raw<T0, T1>(&v0), v2);
        };
        let v8 = PriceUpdated<T0, T1>{
            oracle_id : 0x2::object::uid_to_inner(&arg0.id),
            price     : v1,
        };
        0x2::event::emit<PriceUpdated<T0, T1>>(v8);
    }

    // decompiled from Move bytecode v6
}

