module 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::obligation_query {
    struct ObligationData has copy, drop {
        borrows: vector<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetBorrow>,
        deposits: vector<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::borrow_obligation<T0>(arg0, arg1);
        (0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::debt_types<T0>(v0), 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xab8e9e4b2dd1bbcd4ed7115625b45e580ea871551a95a15d344e674d5410acea::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetDeposit>(&mut v3, 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::new_asset_collateral_from_ctoken(v4, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::value::get_price(arg3, v4, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v4), 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::exchange_rate<T0>(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::AssetBorrow>(&mut v6, 0x11fa2e616be1b72476c2f97f5dc945e14e88ab014b8e10900d9cb8a02fa269a3::types::new_asset_borrow(v7, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::debt::debt(v8, 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::borrow_index::value(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::reserve::borrow_index<T0>(0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::market::reserve_by_type<T0>(arg0, v7))))), 0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::value::get_price(arg3, v7, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v7), *0xf5ba403d72c3c527d632627f19d60b59675c9ef3bfe4feeb2229f738bcbf545a::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            borrows  : v6,
            deposits : v3,
        }
    }

    // decompiled from Move bytecode v6
}

