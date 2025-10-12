module 0x48587e69fe96e7e1c360ddc805c7200b20e8d45825dbc92597109b8a869b0939::xaum_indicator_core {
    struct PriceStorage has store, key {
        id: 0x2::object::UID,
        asset_type: 0x1::type_name::TypeName,
        pyth_feed_id: 0x1::option::Option<0x2::object::ID>,
        latest_price: u256,
        price_history: vector<u256>,
        average_price: u256,
        max_history_length: u64,
        ema120_current: u256,
        ema120_previous: u256,
        ema90_current: u256,
        ema90_previous: u256,
        ema5_current: u256,
        ema5_previous: u256,
        ema_initialized: bool,
    }

    public fun bind_pyth_feed_id(arg0: &mut PriceStorage, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pyth_feed_id), 0);
        arg0.pyth_feed_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    fun calculate_ema(arg0: u256, arg1: u256, arg2: u64) : u256 {
        let v0 = 1000000000000000000;
        let v1 = 2 * v0 / ((arg2 + 1) as u256);
        arg0 * v1 / v0 + arg1 * (v0 - v1) / v0
    }

    public fun create_price_storage(arg0: &mut 0x2::tx_context::TxContext) : PriceStorage {
        PriceStorage{
            id                 : 0x2::object::new(arg0),
            asset_type         : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            pyth_feed_id       : 0x1::option::none<0x2::object::ID>(),
            latest_price       : 0,
            price_history      : 0x1::vector::empty<u256>(),
            average_price      : 0,
            max_history_length : 10,
            ema120_current     : 0,
            ema120_previous    : 0,
            ema90_current      : 0,
            ema90_previous     : 0,
            ema5_current       : 0,
            ema5_previous      : 0,
            ema_initialized    : false,
        }
    }

    public fun get_asset_type(arg0: &PriceStorage) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun get_average_price(arg0: &PriceStorage) : u256 {
        arg0.average_price
    }

    public fun get_ema120_current(arg0: &PriceStorage) : u256 {
        arg0.ema120_current
    }

    public fun get_ema120_previous(arg0: &PriceStorage) : u256 {
        arg0.ema120_previous
    }

    public fun get_ema5_current(arg0: &PriceStorage) : u256 {
        arg0.ema5_current
    }

    public fun get_ema5_previous(arg0: &PriceStorage) : u256 {
        arg0.ema5_previous
    }

    public fun get_ema90_current(arg0: &PriceStorage) : u256 {
        arg0.ema90_current
    }

    public fun get_ema90_previous(arg0: &PriceStorage) : u256 {
        arg0.ema90_previous
    }

    public fun get_ema_initialized(arg0: &PriceStorage) : bool {
        arg0.ema_initialized
    }

    public fun get_history_length(arg0: &PriceStorage) : u64 {
        0x1::vector::length<u256>(&arg0.price_history)
    }

    public fun get_latest_price(arg0: &PriceStorage) : u256 {
        arg0.latest_price
    }

    public fun get_max_history_length(arg0: &PriceStorage) : u64 {
        arg0.max_history_length
    }

    public fun get_price_history(arg0: &PriceStorage) : &vector<u256> {
        &arg0.price_history
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PriceStorage>(create_price_storage(arg0));
    }

    public fun init_ema_values(arg0: &mut PriceStorage, arg1: u256, arg2: u256, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.ema_initialized, 0);
        arg0.ema120_current = arg1;
        arg0.ema120_previous = arg1;
        arg0.ema90_current = arg2;
        arg0.ema90_previous = arg2;
        arg0.ema5_current = arg3;
        arg0.ema5_previous = arg3;
        arg0.ema_initialized = true;
    }

    public fun is_matching_pyth_feed_id(arg0: &PriceStorage, arg1: &0x2::object::ID) : bool {
        if (!0x1::option::is_some<0x2::object::ID>(&arg0.pyth_feed_id)) {
            return false
        };
        *0x1::option::borrow<0x2::object::ID>(&arg0.pyth_feed_id) == *arg1
    }

    public fun is_pyth_feed_bound(arg0: &PriceStorage) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.pyth_feed_id)
    }

    fun update_ema_values(arg0: &mut PriceStorage, arg1: u256) {
        if (!arg0.ema_initialized) {
            arg0.ema120_current = arg1;
            arg0.ema120_previous = arg1;
            arg0.ema90_current = arg1;
            arg0.ema90_previous = arg1;
            arg0.ema5_current = arg1;
            arg0.ema5_previous = arg1;
            arg0.ema_initialized = true;
        } else {
            arg0.ema120_previous = arg0.ema120_current;
            arg0.ema90_previous = arg0.ema90_current;
            arg0.ema5_previous = arg0.ema5_current;
            arg0.ema120_current = calculate_ema(arg1, arg0.ema120_previous, 172800);
            arg0.ema90_current = calculate_ema(arg1, arg0.ema90_previous, 129600);
            arg0.ema5_current = calculate_ema(arg1, arg0.ema5_previous, 7200);
        };
    }

    fun update_price_storage(arg0: &mut PriceStorage, arg1: u256) {
        arg0.latest_price = arg1;
        update_ema_values(arg0, arg1);
        0x1::vector::push_back<u256>(&mut arg0.price_history, arg1);
        if (0x1::vector::length<u256>(&arg0.price_history) > arg0.max_history_length) {
            0x1::vector::remove<u256>(&mut arg0.price_history, 0);
        };
        let v0 = 0;
        let v1 = 0x1::vector::length<u256>(&arg0.price_history);
        let v2 = 0;
        while (v2 < v1) {
            v0 = v0 + *0x1::vector::borrow<u256>(&arg0.price_history, v2);
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            arg0.average_price = v0 / (v1 as u256);
        };
    }

    public fun update_price_storage_external(arg0: &mut PriceStorage, arg1: u256) {
        update_price_storage(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

