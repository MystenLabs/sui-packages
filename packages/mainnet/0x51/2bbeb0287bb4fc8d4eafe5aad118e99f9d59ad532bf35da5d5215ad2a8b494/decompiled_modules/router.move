module 0x512bbeb0287bb4fc8d4eafe5aad118e99f9d59ad532bf35da5d5215ad2a8b494::router {
    struct PumpRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun buy<T0, T1>(arg0: &mut PumpRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::BondingCurve<T1>, arg3: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::Configurator, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, 0x2::sui::SUI>(arg1, &arg4);
        let v0 = 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::buy<T1>(arg2, arg3, arg4, 0, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v0));
        v0
    }

    public fun sell<T0, T1>(arg0: &mut PumpRouterWrapper, arg1: &mut 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::RouterSwapCap<T0>, arg2: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::BondingCurve<T1>, arg3: &mut 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::Configurator, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::assert_expected_coin_in<T0, T1>(arg1, &arg4);
        let v0 = 0x3f2a0baf78f98087a04431f848008bad050cb5f4427059fa08eeefaa94d56cca::curve::sell<T1>(arg2, arg3, arg4, 0, arg5);
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::router::update_path_metadata<T0, 0x2::sui::SUI>(arg1, &arg0.id, 0x2::coin::value<0x2::sui::SUI>(&v0));
        v0
    }

    public fun authorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PumpRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::AdminCap, arg1: &mut PumpRouterWrapper) {
        0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PumpRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PumpRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

