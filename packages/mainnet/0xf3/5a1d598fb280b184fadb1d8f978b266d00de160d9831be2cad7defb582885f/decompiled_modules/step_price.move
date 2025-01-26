module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::step_price {
    struct STEP_PRICE_RULE has drop {
        dummy_field: bool,
    }

    struct Rule<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        initial_price: u64,
        period: u64,
        price_increment: u64,
        factor: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
    }

    public fun new<T0, T1>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg5: &mut 0x2::tx_context::TxContext) : Rule<T0, T1> {
        Rule<T0, T1>{
            id              : 0x2::object::new(arg5),
            initial_price   : arg1,
            period          : arg2,
            price_increment : arg3,
            factor          : arg4,
        }
    }

    public fun update_price<T0, T1>(arg0: &Rule<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = STEP_PRICE_RULE{dummy_field: false};
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool::update_price<T0, T1, STEP_PRICE_RULE>(arg2, arg3, v0, price<T0, T1>(arg0, arg1, arg3));
    }

    public fun destroy<T0, T1>(arg0: Rule<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>) {
        let Rule {
            id              : v0,
            initial_price   : _,
            period          : _,
            price_increment : _,
            factor          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun price<T0, T1>(arg0: &Rule<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::start_time<T0>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 > v0) {
            arg0.initial_price + (v1 - v0) / arg0.period * arg0.price_increment
        } else {
            arg0.initial_price
        };
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(arg0.factor, v2))
    }

    public fun set_factor<T0, T1>(arg0: &mut Rule<T0, T1>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: u64) {
        arg0.factor = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_percent_u64(arg2);
    }

    // decompiled from Move bytecode v6
}

