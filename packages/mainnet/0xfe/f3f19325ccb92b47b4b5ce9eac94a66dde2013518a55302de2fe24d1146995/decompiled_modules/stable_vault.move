module 0xfef3f19325ccb92b47b4b5ce9eac94a66dde2013518a55302de2fe24d1146995::stable_vault {
    struct StableVault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        yield_usdb_balance: 0x2::balance::Balance<T2>,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg4: &mut 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T2>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::WithdrawResponse<T3>) {
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, arg7);
        let (v0, v1) = 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::burn<T3, T2>(arg4, arg1, arg3, arg6, 0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg0.yield_usdb_balance, 0x2::coin::value<T0>(&arg7)), arg8), arg8);
        let v2 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account));
        (0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T1>(arg2, arg1, arg5, v0, &v2, arg8), v1)
    }

    public fun mint<T0, T1, T2, T3>(arg0: &mut StableVault<T0, T1, T2>, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T1>, arg3: &mut 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::SavingPool<T3>, arg4: &mut 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::YieldVault<T3, T2>, arg5: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T1>, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x872d08a70db3db498aa7853276acea8091fdd9871b2d86bc8dcb8524526df622::saving::DepositResponse<T3>) {
        let v0 = 0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account));
        let (v1, v2) = 0xa3367c595c918285a357fe21189cd06463e7f422c779bcfe74c1ef06061e3f78::yield_usdb::mint<T3, T2>(arg4, arg1, arg3, arg6, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T1>(arg2, arg1, arg5, arg7, &v0, arg8), arg8);
        let v3 = v1;
        0x2::balance::join<T2>(&mut arg0.yield_usdb_balance, 0x2::coin::into_balance<T2>(v3));
        (0x2::coin::mint<T0>(&mut arg0.lp_treasury_cap, 0x2::coin::value<T2>(&v3), arg8), v2)
    }

    public fun new<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg3: &mut 0x2::tx_context::TxContext) : StableVault<T0, T1, T2> {
        StableVault<T0, T1, T2>{
            id                 : 0x2::object::new(arg3),
            abstract_account   : arg2,
            yield_usdb_balance : 0x2::balance::zero<T2>(),
            lp_treasury_cap    : arg1,
        }
    }

    public fun default_create<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<StableVault<T0, T1, T2>>(new<T0, T1, T2>(arg0, arg1, arg2, arg3));
    }

    public fun default_destroy<T0, T1, T2>(arg0: &AdminCap, arg1: StableVault<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) {
        let (v0, v1) = destroy<T0, T1, T2>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun destroy<T0, T1, T2>(arg0: &AdminCap, arg1: StableVault<T0, T1, T2>) : (0x2::coin::TreasuryCap<T0>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account) {
        let StableVault {
            id                 : v0,
            abstract_account   : v1,
            yield_usdb_balance : v2,
            lp_treasury_cap    : v3,
        } = arg1;
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T2>(&v5) > 0 || 0x2::coin::total_supply<T0>(&v4) > 0) {
            err_cannot_destroy_non_empty_vault();
        };
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T2>(v5);
        (v4, v1)
    }

    fun err_cannot_destroy_non_empty_vault() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lp_total_supply<T0, T1, T2>(arg0: &StableVault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)
    }

    // decompiled from Move bytecode v6
}

