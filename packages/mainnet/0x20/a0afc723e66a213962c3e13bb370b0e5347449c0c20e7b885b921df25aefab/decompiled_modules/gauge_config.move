module 0x20a0afc723e66a213962c3e13bb370b0e5347449c0c20e7b885b921df25aefab::gauge_config {
    struct GaugeConfig has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        paused: bool,
    }

    public fun coin_xy(arg0: &GaugeConfig) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_x, arg0.coin_y)
    }

    public(friend) fun create<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : GaugeConfig {
        GaugeConfig{
            id      : 0x2::object::new(arg1),
            pool_id : arg0,
            coin_x  : 0x1::type_name::get<T0>(),
            coin_y  : 0x1::type_name::get<T1>(),
            paused  : false,
        }
    }

    public fun is_paused(arg0: &GaugeConfig) : bool {
        arg0.paused
    }

    public fun pool_id(arg0: &GaugeConfig) : address {
        arg0.pool_id
    }

    public(friend) fun set_paused(arg0: &mut GaugeConfig, arg1: bool) {
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

