module 0xc1025fe014b03d33b207b5afb0ba04293be87fab438c1418a26a75c2fe05c223::stable_vault_farm {
    struct StableVaultFarmEntity<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct StableVaultFarmWitness has drop {
        dummy_field: bool,
    }

    struct StableVaultFarm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, StableVaultFarmEntity<T0, T1>>,
        yield_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>,
        u_surplus: 0x2::balance::Balance<T1>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : StableVaultFarm<T0, T1> {
        StableVaultFarm<T0, T1>{
            id          : 0x2::object::new(arg2),
            sheet       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T1, StableVaultFarmEntity<T0, T1>>(stamp<T0, T1>()),
            yield_table : 0x2::table::new<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg2),
            u_surplus   : 0x2::coin::into_balance<T1>(arg1),
        }
    }

    public fun pay<T0, T1, T2, T3, T4>(arg0: &mut StableVaultFarm<T0, T1>, arg1: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>>, arg2: &mut 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::StableVault<T0, T1, T3>, arg3: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg4: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg5: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T4>, arg6: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T3, T4>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T4> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::requirement<T1, 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>>(arg1);
        let v1 = StableVaultFarmWitness{dummy_field: false};
        let (v2, v3) = 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::burn<T0, T1, T3, T4, StableVaultFarmWitness>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::round(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(v0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_scaled_val(0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::exchange_rate<T3, T4>(arg6, arg5, arg8))))), arg9), v1, arg9);
        let v4 = 0x2::coin::into_balance<T1>(v2);
        let v5 = 0x2::balance::value<T1>(&v4);
        if (v5 > v0) {
            0x2::balance::join<T1>(&mut arg0.u_surplus, 0x2::balance::split<T1>(&mut v4, v5 - v0));
        } else if (v5 < v0) {
            0x2::balance::join<T1>(&mut v4, 0x2::balance::split<T1>(&mut arg0.u_surplus, v0 - v5));
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T1, 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>, StableVaultFarmEntity<T0, T1>>(&mut arg0.sheet, arg1, v4, stamp<T0, T1>());
        v3
    }

    public fun receive<T0, T1, T2, T3, T4>(arg0: &mut StableVaultFarm<T0, T1>, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T1, 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>, StableVaultFarmEntity<T0, T1>>, arg2: &mut 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::StableVault<T0, T1, T3>, arg3: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg4: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg5: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T4>, arg6: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T3, T4>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T4> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T1, StableVaultFarmEntity<T0, T1>>(&arg0.sheet), &v0)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T1, StableVaultFarmEntity<T0, T1>>(&mut arg0.sheet, v0, stamp<T0, T1>());
        };
        let (v1, v2) = 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::mint<T0, T1, T3, T4>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T1>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T1, 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>, StableVaultFarmEntity<T0, T1>>(&mut arg0.sheet, arg1, stamp<T0, T1>()), arg9), arg9);
        let v3 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.yield_table, v3)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, v3), 0x2::coin::into_balance<T0>(v1));
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, v3, 0x2::coin::into_balance<T0>(v1));
        };
        v2
    }

    public fun add_surplus<T0, T1>(arg0: &mut StableVaultFarm<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.u_surplus, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun claim<T0, T1, T2, T3, T4>(arg0: &mut StableVaultFarm<T0, T1>, arg1: &0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableRegistry, arg2: &mut 0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::StableVault<T0, T1, T3>, arg3: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg4: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T4>, arg5: &mut 0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T3, T4>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T4>) {
        let v0 = 0x2::tx_context::sender(arg7);
        if (!0x2::vec_set::contains<address>(0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::managers<T2, T1>(0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::borrow_factory<T2, T1>(arg1)), &v0)) {
            err_sender_is_not_manager();
        };
        let v1 = claimable_amount<T0, T1, T2, T3, T4>(arg0, arg4, arg5, arg6);
        if (v1 == 0) {
            err_nothing_to_claim();
        };
        0x839ebd53d7fd8cf4209b83a3937c3875968e2705156717c76760b3b64eef7e3a::stable_vault::burn_to_usdb<T0, T1, T3, T4>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()), v1), arg7), arg7)
    }

    public fun claimable_amount<T0, T1, T2, T3, T4>(arg0: &mut StableVaultFarm<T0, T1>, arg1: &0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T4>, arg2: &0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::YieldVault<T3, T4>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer::StableFactoryEntity<T2, T1>>();
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x203eebc39442014a1b8180f3b8ed70143dac2c5d28ba5703fe34c21052728705::yield_usdb::mint_ratio<T3, T4>(arg2, arg1, arg3), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T1>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::debts<T1, StableVaultFarmEntity<T0, T1>>(&arg0.sheet), &v0))));
        let v2 = 0x2::balance::value<T0>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.yield_table, 0x1::type_name::with_defining_ids<T2>()));
        if (v2 > v1) {
            v2 - v1
        } else {
            0
        }
    }

    public fun default<T0, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StableVaultFarm<T0, T1>>(new<T0, T1>(arg0, arg1, arg2));
    }

    fun err_nothing_to_claim() {
        abort 101
    }

    fun err_sender_is_not_manager() {
        abort 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun stamp<T0, T1>() : StableVaultFarmEntity<T0, T1> {
        StableVaultFarmEntity<T0, T1>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

