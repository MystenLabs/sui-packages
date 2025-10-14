module 0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::obligation_query {
    struct ObligationData has copy, drop {
        emode_group_id: u8,
        borrows: vector<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetBorrow>,
        deposits: vector<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::borrow_obligation<T0>(arg0, arg1);
        (0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt_types<T0>(v0), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_detail<T0>(arg0: &0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::Market<T0>, arg1: 0x2::object::ID, arg2: &0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg4: &0x2::clock::Clock) : ObligationData {
        let v0 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::deposit_types<T0>(v0);
        let v3 = 0x1::vector::empty<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetDeposit>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v1);
            0x1::vector::push_back<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetDeposit>(&mut v3, 0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::new_asset_collateral_from_ctoken(v4, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::ctoken_amount_by_coin<T0>(v0, v4), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg3, v4, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v4), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::exchange_rate<T0>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::reserve_by_type<T0>(arg0, v4))));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v5 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt_types<T0>(v0);
        let v6 = 0x1::vector::empty<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetBorrow>();
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5, v1);
            let v8 = 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::debt<T0>(v0, v7);
            0x1::vector::push_back<0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::AssetBorrow>(&mut v6, 0xefaa31d0ff9c875f47286d839291a47507c8eba93ea34f940012b1f7c8a433d9::types::new_asset_borrow(v7, 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::floor(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::debt::debt(v8, 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::borrow_index::value(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::reserve::borrow_index<T0>(0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::market::reserve_by_type<T0>(arg0, v7))))), 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::value::get_price(arg3, v7, arg4), 0xcfa25712c883ea080ae7cbd067998a134eee2e39cfbcbc4b6b29674117a021ee::coin_decimals_registry::decimals(arg2, v7), *0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::debt::borrow_index(v8)));
            v1 = v1 + 1;
        };
        ObligationData{
            emode_group_id : 0x593a9097f7c268f9e0695969e49cc7cca0ba5398a16360f00aa1d97a8aa4c09b::obligation::emode_group<T0>(v0),
            borrows        : v6,
            deposits       : v3,
        }
    }

    // decompiled from Move bytecode v6
}

