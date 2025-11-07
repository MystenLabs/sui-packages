module 0x1133f36a8d2a7aff2b516b74dbf00b652ee59d700d21dd6f31d8117a14ea1e6b::lake_usd_farm {
    struct LakeUsdFarmEntity<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LakeUsdFarm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, LakeUsdFarmEntity<T0, T1>>,
        yield_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>,
        u_surplus: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : LakeUsdFarm<T0, T1> {
        LakeUsdFarm<T0, T1>{
            id          : 0x2::object::new(arg2),
            sheet       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T1, LakeUsdFarmEntity<T0, T1>>(stamp<T0, T1>()),
            yield_table : 0x2::table::new<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg2),
            u_surplus   : 0x2::coin::into_balance<T1>(arg1),
        }
    }

    public fun claim<T0, T1, T2, T3, T4>(arg0: &mut LakeUsdFarm<T0, T1>, arg1: &0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactory<T2, T1>, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: &mut 0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::StableVault<T0, T1, T4>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg6: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg7: &mut 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T4>, arg8: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3>) {
        0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::assert_sender_is_claimer<T2, T1>(arg1, arg2);
        let v0 = claimable_amount<T0, T1, T2, T3, T4>(arg0, arg6, arg7, arg9);
        if (v0 == 0) {
            err_nothing_to_claim();
        };
        0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::burn<T0, T1, T4, T3>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()), v0), arg10), arg10)
    }

    public fun claimable_amount<T0, T1, T2, T3, T4>(arg0: &mut LakeUsdFarm<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg2: &0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T4>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>>();
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::round(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T1>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T1, LakeUsdFarmEntity<T0, T1>>(&arg0.sheet), &v0))), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_scaled_val(0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::exchange_rate<T3, T4>(arg2, arg1, arg3))));
        let v2 = 0x2::balance::value<T0>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()));
        if (v2 > v1) {
            v2 - v1
        } else {
            0
        }
    }

    public fun default<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LakeUsdFarm<T0, T1>>(new<T0, T1>(arg0, arg1, arg2));
    }

    fun err_nothing_to_claim() {
        abort 101
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun pay<T0, T1, T2, T3, T4>(arg0: &mut LakeUsdFarm<T0, T1>, arg1: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>>, arg2: &mut 0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::StableVault<T0, T1, T4>, arg3: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg4: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg5: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg6: &mut 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T4>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::requirement<T1, 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>>(arg1);
        let (v1, v2) = 0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::burn<T0, T1, T4, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::round(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(v0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_scaled_val(0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::exchange_rate<T3, T4>(arg6, arg5, arg8))))), arg9), arg9);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = 0x2::balance::value<T1>(&v3);
        if (v4 > v0) {
            0x2::balance::join<T1>(&mut arg0.u_surplus, 0x2::balance::split<T1>(&mut v3, v4 - v0));
        } else if (v4 < v0) {
            0x2::balance::join<T1>(&mut v3, 0x2::balance::split<T1>(&mut arg0.u_surplus, v0 - v4));
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T1, 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>, LakeUsdFarmEntity<T0, T1>>(&mut arg0.sheet, arg1, v3, stamp<T0, T1>());
        v2
    }

    public fun receive<T0, T1, T2, T3, T4>(arg0: &mut LakeUsdFarm<T0, T1>, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T1, 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>, LakeUsdFarmEntity<T0, T1>>, arg2: &mut 0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::StableVault<T0, T1, T4>, arg3: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg4: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg5: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg6: &mut 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T4>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T3> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T1, LakeUsdFarmEntity<T0, T1>>(&arg0.sheet), &v0)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T1, LakeUsdFarmEntity<T0, T1>>(&mut arg0.sheet, v0, stamp<T0, T1>());
        };
        let (v1, v2) = 0x99800edc7e6f4485d05e08763ecba8887e7c08b11cb52574ddc8c5bfdc6d0c7a::stable_vault::mint<T0, T1, T4, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T1>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T1, 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory::StableFactoryEntity<T2, T1>, LakeUsdFarmEntity<T0, T1>>(&mut arg0.sheet, arg1, stamp<T0, T1>()), arg9), arg9);
        let v3 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.yield_table, v3)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, v3), 0x2::coin::into_balance<T0>(v1));
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, v3, 0x2::coin::into_balance<T0>(v1));
        };
        v2
    }

    fun stamp<T0, T1>() : LakeUsdFarmEntity<T0, T1> {
        LakeUsdFarmEntity<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

