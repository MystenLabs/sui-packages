module 0x985a81917a9632acfa47f8e402ed389d0765f29eae25fc6bbbe047436fb6e5::steamm_lp_provider {
    struct SteammLp has drop {
        dummy_field: bool,
    }

    struct SteammLpProvider has key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        managers: 0x2::vec_set::VecSet<address>,
    }

    fun account_req_opt(arg0: &SteammLpProvider) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest> {
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account))
    }

    public fun add_lp_type<T0>(arg0: &mut SteammLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>(), 0x2::balance::zero<T0>());
    }

    public fun add_manager(arg0: &mut SteammLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_usdb_a_liquidity<T0, T1, T2, T3, T4: store, T5: drop>(arg0: &mut SteammLpProvider, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T2, T3, T4, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T2>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg9: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg10: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg11);
        let v0 = account_req_opt(arg0);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg6), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T1>(arg9)));
        let v2 = SteammLp{dummy_field: false};
        let v3 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<SteammLp>(arg8, v2, package_version(), arg5 + v1, arg11);
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T1>(arg9, arg8, arg10, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v3, v1, arg11), &v0, arg11);
        let v5 = SteammLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<SteammLp>(arg8, v5, package_version(), v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::balance::join<T5>(borrow_lp_mut<T5>(arg0), 0x2::coin::into_balance<T5>(0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::deposit_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, &mut v3, &mut v4, arg5, arg6, arg7, arg11)));
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T2>(arg2, arg4, arg7, arg11);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::rebalance<T0, T1, T3>(arg3, arg4, arg7, arg11);
    }

    public fun assert_sender_is_manager(arg0: &mut SteammLpProvider, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun borrow_lp_mut<T0>(arg0: &mut SteammLpProvider) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            err_lp_type_not_supported();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    fun err_lp_type_not_supported() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SteammLpProvider{
            id               : 0x2::object::new(arg0),
            abstract_account : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")), arg0),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<SteammLpProvider>(v0);
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_lp_type<T0>(arg0: &mut SteammLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>()), arg2)
    }

    public fun remove_manager(arg0: &mut SteammLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    // decompiled from Move bytecode v6
}

