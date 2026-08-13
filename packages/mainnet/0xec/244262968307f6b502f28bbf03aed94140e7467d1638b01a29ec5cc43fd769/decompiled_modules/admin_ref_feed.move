module 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::admin_ref_feed {
    struct AdminRefPriceUpdated has copy, drop {
        x_oracle: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        spot: u64,
        ema: u64,
        who: address,
        timestamp_ms: u64,
    }

    public fun admin_set_ref_price<T0>(arg0: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::AdminCap, arg1: &mut 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::admin_ref_feed_registry_mut(arg1);
        if (0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset_registry::has_asset<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::AdminReference>(v2, v0)) {
            0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::update(0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset_registry::borrow_mut<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::AdminReference>(v2, v0), arg2, arg3, v1);
        } else {
            0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset_registry::set<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::AdminReference>(v2, v0, 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::new(arg2, arg3, v1));
        };
        let v3 = AdminRefPriceUpdated{
            x_oracle     : 0x2::object::id<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle>(arg1),
            coin_type    : v0,
            spot         : arg2,
            ema          : arg3,
            who          : 0x2::tx_context::sender(arg5),
            timestamp_ms : v1,
        };
        0x2::event::emit<AdminRefPriceUpdated>(v3);
    }

    public fun refresh_admin_ref_price_feed<T0>(arg0: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg1: 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::update::OracleUpdateHotPotato<T0>) : 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::update::OracleUpdateHotPotato<T0> {
        0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::ensure_version_matches(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::admin_ref_feed_registry(arg0);
        assert!(0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset_registry::has_asset<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::AdminReference>(v1, v0), 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::oracle_error::admin_ref_not_set());
        let v2 = 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset_registry::borrow<0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::AdminReference>(v1, v0);
        let v3 = 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::updated_at(v2) / 1000;
        0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::update::insert_price_feed<T0>(arg1, 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::asset::admin_ref_source(), 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::price_feed::new(0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::price_feed::new_component(0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::spot(v2), v3), 0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::price_feed::new_component(0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::reference::ema(v2), v3)))
    }

    // decompiled from Move bytecode v6
}

