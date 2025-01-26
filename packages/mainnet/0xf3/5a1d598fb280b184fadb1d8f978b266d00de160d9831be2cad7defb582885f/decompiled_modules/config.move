module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::config {
    struct Config<phantom T0> has store, key {
        id: 0x2::object::UID,
        valid_versions: 0x2::vec_set::VecSet<u64>,
        final_ratio: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        holders_ratio: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        referrer_ratio: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        winner_distribution: vector<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>,
        referral_threshold: u64,
        referral_factor: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        initial_countdown: u64,
        time_increment: u64,
        end_time_hard_cap: u64,
    }

    public fun new<T0>(arg0: &mut 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg2: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg3: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg4: vector<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>, arg5: u64, arg6: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Config<T0> {
        if (0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::gt(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(arg1, arg2), arg3), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(1))) {
            err_invalid_ratio();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0);
        0x1::vector::reverse<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(&mut arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(&arg4)) {
            v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(v0, 0x1::vector::pop_back<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(&mut arg4));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(arg4);
        if (v0 != 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(1)) {
            err_invalid_distribution();
        };
        let v2 = Config<T0>{
            id                  : 0x2::object::new(arg10),
            valid_versions      : 0x2::vec_set::singleton<u64>(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::version::package_version()),
            final_ratio         : arg1,
            holders_ratio       : arg2,
            referrer_ratio      : arg3,
            winner_distribution : arg4,
            referral_threshold  : arg5,
            referral_factor     : arg6,
            initial_countdown   : arg7,
            time_increment      : arg8,
            end_time_hard_cap   : arg9,
        };
        0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::set_config_id<T0>(arg0, 0x2::object::id<Config<T0>>(&v2));
        v2
    }

    public fun add_version<T0>(arg0: &mut Config<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(valid_versions<T0>(arg0), &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.valid_versions, arg2);
        };
    }

    public fun assert_valid_package_version<T0>(arg0: &Config<T0>) {
        let v0 = 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::version::package_version();
        if (!0x2::vec_set::contains<u64>(valid_versions<T0>(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    public fun end_time_hard_cap<T0>(arg0: &Config<T0>) : u64 {
        arg0.end_time_hard_cap
    }

    fun err_invalid_distribution() {
        abort 1
    }

    fun err_invalid_package_version() {
        abort 2
    }

    fun err_invalid_ratio() {
        abort 0
    }

    public fun final_ratio<T0>(arg0: &Config<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.final_ratio
    }

    public fun holders_ratio<T0>(arg0: &Config<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.holders_ratio
    }

    public fun initial_countdown<T0>(arg0: &Config<T0>) : u64 {
        arg0.initial_countdown
    }

    public fun max_winner_count<T0>(arg0: &Config<T0>) : u64 {
        0x1::vector::length<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float>(&arg0.winner_distribution)
    }

    public fun referral_factor<T0>(arg0: &Config<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.referral_factor
    }

    public fun referral_threshold<T0>(arg0: &Config<T0>) : u64 {
        arg0.referral_threshold
    }

    public fun referrer_ratio<T0>(arg0: &Config<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.referrer_ratio
    }

    public fun remove_version<T0>(arg0: &mut Config<T0>, arg1: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::admin::AdminCap<T0>, arg2: u64) {
        if (0x2::vec_set::contains<u64>(valid_versions<T0>(arg0), &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.valid_versions, &arg2);
        };
    }

    public fun time_increment<T0>(arg0: &Config<T0>) : u64 {
        arg0.time_increment
    }

    public fun valid_versions<T0>(arg0: &Config<T0>) : &0x2::vec_set::VecSet<u64> {
        &arg0.valid_versions
    }

    public fun winner_distribution<T0>(arg0: &Config<T0>) : &vector<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float> {
        &arg0.winner_distribution
    }

    // decompiled from Move bytecode v6
}

