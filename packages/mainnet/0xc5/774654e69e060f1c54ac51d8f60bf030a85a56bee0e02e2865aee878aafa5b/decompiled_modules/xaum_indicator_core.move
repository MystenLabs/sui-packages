module 0xc5774654e69e060f1c54ac51d8f60bf030a85a56bee0e02e2865aee878aafa5b::xaum_indicator_core {
    struct PriceStorage has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun assert_admin(arg0: &PriceStorage, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 1);
    }

    public fun bind_admin_cap(arg0: &mut PriceStorage, arg1: &AdminCap, arg2: 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracleAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = AdminCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AdminCapKey, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracleAdminCap>(&mut arg0.id, v0, arg2);
    }

    public fun bind_pyth_feed_id(arg0: &mut PriceStorage, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pyth_feed_id), 0);
        arg0.pyth_feed_id = 0x1::option::some<0x2::object::ID>(arg2);
    }

    fun calculate_ema(arg0: u256, arg1: u256, arg2: u64) : u256 {
        let v0 = 1000000000000000000;
        let v1 = 2 * v0 / ((arg2 + 1) as u256);
        arg0 * v1 / v0 + arg1 * (v0 - v1) / v0
    }

    fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    fun create_owner_cap(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        OwnerCap{id: 0x2::object::new(arg0)}
    }

    public fun create_price_storage(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : PriceStorage {
        PriceStorage{
            id                 : 0x2::object::new(arg1),
            admin_cap_id       : arg0,
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
        let v0 = create_admin_cap(arg0);
        let v1 = create_price_storage(0x2::object::id<AdminCap>(&v0), arg0);
        0x2::transfer::share_object<PriceStorage>(v1);
        let v2 = create_owner_cap(arg0);
        0x2::transfer::transfer<OwnerCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun init_ema_values(arg0: &AdminCap, arg1: &mut PriceStorage, arg2: u256, arg3: u256, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        assert!(!arg1.ema_initialized, 0);
        arg1.ema120_current = arg2;
        arg1.ema120_previous = arg2;
        arg1.ema90_current = arg3;
        arg1.ema90_previous = arg3;
        arg1.ema5_current = arg4;
        arg1.ema5_previous = arg4;
        arg1.ema_initialized = true;
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

    public fun push_gr_indicators_to_x_oracle(arg0: &PriceStorage, arg1: &AdminCap, arg2: &mut 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = AdminCapKey{dummy_field: false};
        0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::set_gr_indicators(arg2, 0x2::dynamic_object_field::borrow<AdminCapKey, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracleAdminCap>(&arg0.id, v0), ((arg0.ema120_current / 1000000000) as u64), ((arg0.ema90_current / 1000000000) as u64), ((arg0.latest_price / 1000000000) as u64), 0x2::clock::timestamp_ms(arg3) / 1000, arg4);
    }

    public fun set_admin_cap(arg0: &OwnerCap, arg1: &mut PriceStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_admin_cap(arg3);
        arg1.admin_cap_id = 0x2::object::id<AdminCap>(&v0);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public fun set_price_9dec(arg0: &AdminCap, arg1: &mut PriceStorage, arg2: u64, arg3: &mut 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg0);
        assert!(arg2 > 0, 0);
        update_price_storage(arg1, (arg2 as u256) * 1000000000);
        push_gr_indicators_to_x_oracle(arg1, arg0, arg3, arg4, arg5);
    }

    public fun transfer_owner_cap(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
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

