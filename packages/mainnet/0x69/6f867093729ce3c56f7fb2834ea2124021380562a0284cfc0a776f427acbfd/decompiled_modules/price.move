module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price {
    struct PriceCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceRequestLock has key {
        id: 0x2::object::UID,
    }

    struct PriceRequest<phantom T0> {
        mark_price: 0x1::option::Option<u64>,
    }

    fun add_price_request_lock(arg0: &mut PriceRequestLock) {
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, b"price_request_lock", true);
    }

    fun assert_price_request_lock(arg0: &PriceRequestLock) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"price_request_lock"), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::price_request_locked());
    }

    public fun burn<T0>(arg0: PriceRequest<T0>, arg1: &mut PriceRequestLock) {
        let PriceRequest { mark_price: v0 } = arg0;
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0);
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        remove_price_request_lock(arg1);
    }

    public fun burn_price_cap(arg0: PriceCap, arg1: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg1);
        let PriceCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceRequestLock{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PriceRequestLock>(v0);
    }

    public fun issue<T0>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg1: &mut PriceRequestLock) : PriceRequest<T0> {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg0);
        assert_price_request_lock(arg1);
        add_price_request_lock(arg1);
        PriceRequest<T0>{mark_price: 0x1::option::none<u64>()}
    }

    public fun mark_price<T0>(arg0: &PriceRequest<T0>) : u64 {
        *0x1::option::borrow<u64>(&arg0.mark_price)
    }

    public(friend) fun new_price_cap(arg0: &mut 0x2::tx_context::TxContext) : PriceCap {
        PriceCap{id: 0x2::object::new(arg0)}
    }

    fun remove_price_request_lock(arg0: &mut PriceRequestLock) {
        0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, b"price_request_lock");
    }

    public fun set_mark_price<T0>(arg0: &PriceCap, arg1: &mut PriceRequest<T0>, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg3: u64) {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::assert_current_version(arg2);
        0x1::option::fill<u64>(&mut arg1.mark_price, arg3);
    }

    public fun verify<T0>(arg0: &PriceRequest<T0>) {
        assert!(0x1::option::is_some<u64>(&arg0.mark_price), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::price_not_set());
    }

    // decompiled from Move bytecode v6
}

